import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditprofileScreen extends StatefulWidget {
  const EditprofileScreen({Key? key}) : super(key: key);

  @override
  State<EditprofileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  TextEditingController _usernameController  = TextEditingController();

  bool _isLoading = false;
  String _username = '';
  String _userimage='';
  File? _image;

  Future<void> _uploadToFirebase(
      File userImage,
      String userName,

      ) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Uploading! Please wait',style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        elevation: 4.0,
      ),
    );
    FocusScope.of(context).unfocus();
    // if (userImage == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Upload Image')),
    //   );
    //   return;
    // }

    setState(() {
      _isLoading = true;
    });
    final currentUser = FirebaseAuth.instance.currentUser;

    final userExistingData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.uid)
        .get();

    String? uniqueId = DateTime.now().millisecondsSinceEpoch.toString();

    final Reference storageRef = FirebaseStorage.instance.ref().child('images');
    final taskSnapshot =
    await storageRef.child('${uniqueId}' + '.jpg').putFile(userImage);
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.uid)
        .update({
      'username': userName,
      'userimage':downloadUrl,
    });

    setState(() {
      _isLoading = false;
    });
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
      _usernameController.text  =_username;
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Do something when the menu icon is pressed
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.cyan[300],
        toolbarHeight: 60,
        title: Text('Edit Profile'),
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
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
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
                height: 20,
              ),

              SizedBox(
                height: 20,
              ),
              // First Dropdown

              MaterialButton(
                onPressed: () {
                  _uploadToFirebase(
                    _image!,
                    _username,
                  );
                  // if (_formKey.currentState!.validate()) {
                  //   // If the form is valid, display a snackbar. In the real world,
                  //   // you'd often call a server or save the information in a database.
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text('Processing Data')),
                  //   );
                  //
                  //
                  // }
                },
                minWidth: double.infinity,
                height: 60,
                color: Colors.cyan[300],
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  'SUBMIT',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
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
  @override
  void dispose() {
    super.dispose();
  }

}
