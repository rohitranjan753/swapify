import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';

List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class SellPage extends StatefulWidget {
  const SellPage({Key? key}) : super(key: key);

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  // Initial Selected Value
  String dropdownvalue = 'Notes';

  // List of items in our dropdown menu
  var items = ['Notes','Clothes','Footwear','Stationary','Gadgets'
  ];
  bool _isLoading = false;
  String _titleText = '';
  String _descriptionText = '';
  String _rentalPrice = '';
  File? _image;

  Future<void> _uploadToFirebase(
    File rentImage,
    String rentTile,
    String rentDes,
    String rentPrice,
  ) async {
    setState(() {
      _isLoading = true;
    });
    final currentUser = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.uid)
        .get();

    String? uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    String userName = userData.get('username');

    final Reference storageRef = FirebaseStorage.instance.ref().child('images');
    final taskSnapshot =
        await storageRef.child('${uniqueId}' + '.jpg').putFile(rentImage);
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    final DocumentReference parentDocRef =
        FirebaseFirestore.instance.collection('Users').doc(currentUser.uid);

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
      'createdby': currentUser.uid,
      'creatorname': userName,
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

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Section'),
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
                                image: AssetImage('assets/images/upload3.png'),
                                fit: BoxFit.contain,
                              ),
                      ),
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
                Container(
                  width: myWidth,
                  child: DropdownButton(
                    // hint: Text('Select Category'),
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _uploadToFirebase(
                        _image!, _titleText, _descriptionText, _rentalPrice);
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
