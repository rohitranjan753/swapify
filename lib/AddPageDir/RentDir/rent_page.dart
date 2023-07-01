import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vbuddyproject/Constants/color_constant.dart';
import 'package:vbuddyproject/Constants/image_string.dart';
import 'package:vbuddyproject/Constants/sizes.dart';
import 'package:vbuddyproject/widget/back_btn_design.dart';

class RentPage extends StatefulWidget {
  const RentPage({Key? key}) : super(key: key);

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedFirstValue;
  String? _selectedSecondValue;
  String? _perHrValue;

  // List of items in our dropdown menu
  List<String> _firstDropdownOptions = [
    'Books',
    'Clothes',
    "Electronics",
    'Footwear',
    'Gadgets',
    "Music",
    "Room Utility",
    'Stationary',
    "Sports",
    "Others"
  ];

  // Define the options for the second dropdown, based on the selected value of the first dropdown
  Map<String, List<String>> _secondDropdownOptions = {
    'Books': [
      'DSA',
      'DBMS',
      'Operating System',
      'Java',
      'TOC',
      'Data mining',
      'Others'
    ],
    'Clothes': ['Formal', 'Ethnic', 'Casual', 'Others'],
    'Electronics': ['Table lamp', 'Extension board', 'Others'],
    'Footwear': ['Sports', 'Formal', 'Casual', 'Others'],
    'Gadgets': [
      'Earphone',
      'Charger',
      'Speaker',
      'Laptop',
      'Keyboard',
      'Others'
    ],
    'Music': ['Guitar', 'Electric Guitar', 'Piano Keyboard', 'Drum', 'Others'],
    'Room Utility': [
      'Mattress',
      'Lock key',
      "Bucket",
      "Mug",
      "Clothes hanger",
      "Clothes clip",
      'Bottle',
      'Others'
    ],
    'Stationary': ['Notebook', 'Calculator', 'Pen', 'Others'],
    'Sports': [
      'Bat',
      'Ball',
      'Basketball',
      'Badminton',
      'Volleyball',
      'Others'
    ],
    "Others": ["Cycle", "Umbrella", "Skate Board", 'Others'],
  };

  List<String> _perHrValueList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24'
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
    String firstDropdownValue,
    String secondDropdownValue,
    String perHourDropdownValue,
  ) async {
    rentDes = rentDes.trim();
    rentTile = rentTile.trim();
    rentPrice = rentPrice.trim();

    FocusScope.of(context).unfocus();
    if (rentImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Upload Image'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

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
    String userEmail = userData.get('email');

    final Reference storageRef = FirebaseStorage.instance.ref().child('images');
    final taskSnapshot =
        await storageRef.child('${uniqueId}' + '.jpg').putFile(rentImage);
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    final DocumentReference parentDocRef =
        FirebaseFirestore.instance.collection('Users').doc(currentUser.uid);

    parentDocRef.collection('rentsection').doc(uniqueId).set({
      'imageUrl': downloadUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'renttitle': rentTile,
      'rentdescription': rentDes,
      'rentprice': rentPrice,
      'rentmajorcategory': firstDropdownValue,
      'rentsubcategory': secondDropdownValue,
      'perhourvalue': perHourDropdownValue,
    });

    await FirebaseFirestore.instance
        .collection('rent_major_section')
        .doc(uniqueId)
        .set({
      'imageUrl': downloadUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'renttitle': rentTile,
      'rentdescription': rentDes,
      'rentprice': rentPrice,
      'rentmajorcategory': firstDropdownValue,
      'rentsubcategory': secondDropdownValue,
      'createdby': currentUser.uid,
      'creatorname': userName,
      'creatormail': userEmail,
      'perhourvalue': perHourDropdownValue,
    });

    await FirebaseFirestore.instance
        .collection('all_section')
        .doc(uniqueId)
        .set({
      'imageUrl': downloadUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'title': rentTile,
      'description': rentDes,
      'price': rentPrice,
      'majorcategory': firstDropdownValue,
      'subcategory': secondDropdownValue,
      'createdby': currentUser.uid,
      'creatorname': userName,
      'category': "rent",
      'creatormail': userEmail,
      'perhourvalue': perHourDropdownValue,
    });

    setState(() {
      _isLoading = false;
    });

    Fluttertoast.showToast(
      msg: 'Uploaded',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
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
        leading: const backiconButtonDesign(),
        title: Text(
          'RENT UPLOAD',
          style: TextStyle(letterSpacing: textLetterSpacingValue),
        ),
        toolbarHeight: 60,
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
                child: Form(
                  key: _formKey,
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            height: myHeight * 0.3,
                            width: myWidth * 0.7,
                            decoration: BoxDecoration(
                              image: _image != null
                                  ? DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.cover,
                                    )
                                  : DecorationImage(
                                      image: AssetImage(addPageUploadSign),
                                      fit: BoxFit.contain,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        key: ValueKey('_titleText'),
                        autocorrect: true,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (value) {
                          setState(() {
                            _titleText = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Title",
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter Title',
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Pleas enter title!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLength: descriptionLimitValue,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (value) {
                          setState(() {
                            _descriptionText = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Description',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter Description',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Description can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _rentalPrice = value;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: "Rent Price",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter Price',
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value == null) {
                                  return 'Price field empty';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0
                                    ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: DropdownButton<String>(
                                icon: Icon(Icons.keyboard_arrow_down_rounded),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                hint: Text(
                                  "/hr value",
                                  style: TextStyle(fontSize: 20),
                                ),
                                value: _perHrValue,
                                onChanged: (hrValue) {
                                  setState(() {
                                    _perHrValue = hrValue;
                                  });
                                },
                                items: _perHrValueList.map((hrOption) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      hrOption,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    value: hrOption,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      // First Dropdown
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: DropdownButton<String>(
                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          hint: Text(
                            "Enter Item Category",
                            style: TextStyle(fontSize: 20),
                          ),
                          value: _selectedFirstValue,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedFirstValue = newValue;

                              // Set the selected value of the second dropdown to null, to reset it
                              _selectedSecondValue = null;
                            });
                          },
                          items: _firstDropdownOptions.map((option) {
                            return DropdownMenuItem(
                              child: Text(
                                option,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              value: option,
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Second Dropdown, only visible when first dropdown is selected
                      if (_selectedFirstValue != null)
                        DropdownButton<String>(
                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          hint: Text(
                            "Enter Sub Category",
                            style: TextStyle(fontSize: 20),
                          ),
                          value: _selectedSecondValue,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedSecondValue = newValue;
                            });
                          },
                          items: _secondDropdownOptions[_selectedFirstValue]!
                              .map((option) {
                            return DropdownMenuItem(
                              child: Text(
                                option,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              value: option,
                            );
                          }).toList(),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (_image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Choose Image'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (_selectedFirstValue == null ||
                              _selectedSecondValue == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Choose Category'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (!isNumberAndPositive(_rentalPrice)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invalid Price'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (_perHrValue == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Choose per hr'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Uploading! Please wait',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                                backgroundColor:
                                    navBarBackgroundColour,
                                behavior: SnackBarBehavior.floating,
                                elevation: 4.0,
                              ),
                            );

                            _uploadToFirebase(
                                _image!,
                                _titleText,
                                _descriptionText,
                                _rentalPrice,
                                _selectedFirstValue!,
                                _selectedSecondValue!,
                                _perHrValue!);
                            setState(() {
                              _image = null;
                              _selectedFirstValue = null;
                              _selectedSecondValue = null;
                              _perHrValue = null;
                            });
                          }
                        },
                        minWidth: double.infinity,
                        height: 60,
                        color: Colors.deepPurple,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(
                              fontWeight: buttonTextWeight,
                              letterSpacing: textLetterSpacingValue,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
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

  bool isNumberAndPositive(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}
