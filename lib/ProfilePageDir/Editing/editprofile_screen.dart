import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vbuddyproject/Constants/color_constant.dart';
import 'package:vbuddyproject/Constants/sizes.dart';
import 'package:vbuddyproject/widget/back_btn_design.dart';

class EditprofileScreen extends StatefulWidget {
  const EditprofileScreen({Key? key}) : super(key: key);

  @override
  State<EditprofileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  TextEditingController _usernameController = TextEditingController();

  bool _isLoading = false;
  String _username = '';
  String _userimage = '';
  File? _image;

  Future<void> _updateUsernameOnly(String newUsername) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Uploading! Please wait',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: navBarBackgroundColour,
        behavior: SnackBarBehavior.floating,
        elevation: 4.0,
      ),
    );
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    final currentUser = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.uid)
        .update({
      'username': newUsername,
    });

    setState(() {
      _isLoading = false;
    });

    // Show a snackbar or any other notification to indicate successful update
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Profile updated successfully!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        elevation: 4.0,
      ),
    );

    // Update the text field with the new username
    setState(() {
      _username = newUsername;
      _usernameController.text = _username;
    });
  }



  Future<void> _uploadToFirebase(File? userImage, String userName) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Updating! Please wait',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        elevation: 4.0,
      ),
    );
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    final currentUser = FirebaseAuth.instance.currentUser;

    if (userImage != null) {
      String? uniqueId = DateTime.now().millisecondsSinceEpoch.toString();

      final Reference storageRef =
      FirebaseStorage.instance.ref().child('images');
      final taskSnapshot = await storageRef
          .child('${uniqueId}' + '.jpg')
          .putFile(userImage);
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser!.uid)
          .update({
        'userimage': downloadUrl,
      });
    }

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.uid)
        .update({
      'username': userName,
    });

    setState(() {
      _isLoading = false;
    });

    // Show a snackbar or any other notification to indicate successful update
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text(
    //       'Profile updated successfully!',
    //       style: TextStyle(
    //         color: Colors.white,
    //         fontSize: 16.0,
    //       ),
    //     ),
    //     backgroundColor: Colors.green,
    //     behavior: SnackBarBehavior.floating,
    //     elevation: 4.0,
    //   ),
    // );

    // Update the text field with the new username
    setState(() {
      _username = userName;
      _usernameController.text = _username;
    });

    Fluttertoast.showToast(
      msg: 'Uploaded',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );

    @override
    void dispose() {
      super.dispose();
    }
  }


  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    setState(() {
      _userimage = userDoc.get('userimage');
      _username = userDoc.get('username').toString();
      _usernameController.text = _username;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: backiconButtonDesign(),
        toolbarHeight: 60,
        title: Text('EDIT PROFILE',style: TextStyle(
          letterSpacing: textLetterSpacingValue
        ),),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
        ),
      ),
      body: _isLoading
          ? _buildLoadingIndicator()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _getImage();
                      },
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Container(
                          height: myHeight * 0.15,
                          width: myWidth * 0.31,
                          decoration: BoxDecoration(
                            image: _image != null
                                ? DecorationImage(
                                    image: FileImage(_image!),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: NetworkImage(_userimage),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      // initialValue: _username,
                      onChanged: (value) {
                        setState(() {
                          _username = value;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        icon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Username field is empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (_usernameController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Username field is empty.'),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          if (_image != null && _image!.path != _userimage) {
                            // Image has changed, update the image
                            await _uploadToFirebase(_image, _usernameController.text);
                          }  else {
                            // Username has not changed, update only the username
                            await _updateUsernameOnly(_usernameController.text);
                          }
                        }
                      },
                      minWidth: myWidth*0.7,
                      height: 60,
                      color: Colors.deepPurple,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                            letterSpacing: textLetterSpacingValue,
                            fontWeight: buttonTextWeight,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }


}
