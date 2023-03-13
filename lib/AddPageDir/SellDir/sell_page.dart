import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SellPage extends StatefulWidget {
  const SellPage({Key? key}) : super(key: key);

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  bool _isLoading = false;
  String _titleText = '';
  String _descriptionText = '';
  String _rentalPrice = '';
  File? _image;

  Future<void> _uploadToFirebase(
    var rentImage,
    String rentTile,
    String rentDes,
    String rentPrice,
  ) async {
    setState(() {
      _isLoading = true;
    });
    final currentUser = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('Users').doc(currentUser!.uid).get();
    // final currentTime = currentUser!.uid;
    String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    // String? userName = userData.get('username').toString();


    // final DocumentSnapshot userDoc =
    // await FirebaseFirestore.instance.collection('Users').doc(currentUser.uid).get();
    //   String? username = userDoc.get('username').toString();


    // Timestamp timestamp = Timestamp.now();
    // String timestampString = timestamp.toString();
    final Reference storageRef = FirebaseStorage.instance.ref().child('images');
    // final taskSnapshot = await storageRef.child(_image!.path).putFile(_image!);
    final taskSnapshot =
        await storageRef.child('${uniqueId}' + '.jpg').putFile(_image!);
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    // final CollectionReference users =
    //     FirebaseFirestore.instance.collection('Users');
    final DocumentReference parentDocRef =
        FirebaseFirestore.instance.collection('Users').doc(currentUser!.uid);

    parentDocRef.collection('sellsection').doc(uniqueId).set({
      'imageUrl': downloadUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'selltitle': rentTile,
      'selldescription': rentDes,
      'sellprice': rentPrice,
    });

    await FirebaseFirestore.instance
        .collection('sell_major_section')
        .doc(uniqueId)
        .set({
      'imageUrl': downloadUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'selltitle': rentTile,
      'selldescription': rentDes,
      'sellprice': rentPrice,
      'createdby': currentUser!.uid,
      // 'creatorname': userName,
      // 'image_url': url,
    });

    setState(() {
      _isLoading = false;
    });
    // final DocumentReference userRef = users.doc(currentUser.uid);
    // Map<String, dynamic> data = {
    //   'imageUrl': downloadUrl,
    //   'createdAt': FieldValue.serverTimestamp(),
    // };

    // Map<String, dynamic> data = {
    //   'imageUrl': downloadUrl,
    //   'createdAt': FieldValue.serverTimestamp(),
    // };
    // await userRef.update(data);
  }
  // ) async {
  //   print(rentImage);
  //
  //
  //   User? user = FirebaseAuth.instance.currentUser;
  //   String uid = user!.uid;
  //
  //   final CollectionReference userDoc =
  //       FirebaseFirestore.instance.collection('Users');
  //
  //   try {
  //     setState(() {
  //       if (_isLoading) Center(child: CircularProgressIndicator());
  //     });
  //     final ref = FirebaseStorage.instance
  //         .ref()
  //         .child('user_image')
  //         .child(user.uid + '.jpg');
  //
  //     await ref.putFile(rentImage);
  //     final url = await ref.getDownloadURL();
  //
  //     Map<String, dynamic> data = {
  //       'sell_image_url': rentImage,
  //       'sell_title': rentTile,
  //       'sell_description': rentDes,
  //       'sell_price': rentPrice,
  //     };
  //
  //     await userDoc.doc(uid).set(data);
  //   } on FirebaseAuthException catch (e) {
  //     String? message = "An error occured, Check credential";
  //     if (e.message != null) {
  //       message = e.message;
  //     }
  //
  //     Scaffold.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(message!),
  //         backgroundColor: Theme.of(context).errorColor,
  //       ),
  //     );
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     print(e);
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

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

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Screen'),
      ),
      body: _isLoading
          ? _buildLoadingIndicator()
          : Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _getImage();
                  },
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: myHeight * 0.2,
                      width: myWidth * 0.5,
                      decoration: BoxDecoration(
                        image: _image != null
                            ? DecorationImage(
                                image: FileImage(_image!),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: AssetImage('assets/profile/12.jpg'),
                                fit: BoxFit.cover,
                              ),
                      ),
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //   image: _image != null ? DecorationImage(
                      //     image: FileImage(_image!),
                      //     fit: BoxFit.cover,
                      //   ) : null,
                      //   fit: BoxFit.cover,
                      // ),),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _titleText = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter title',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _descriptionText = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter description',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _rentalPrice = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter price',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    _uploadToFirebase(
                        _image, _titleText, _descriptionText, _rentalPrice);
                    setState(() {
                      _image = null;
                    });
                  },
                  child: Text('SUBMIT'),
                ),
              ],
            ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
