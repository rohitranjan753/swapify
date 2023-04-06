import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class SellPage extends StatefulWidget {
  const SellPage({Key? key}) : super(key: key);

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedFirstValue;
  String? _selectedSecondValue;
  // Initial Selected Value
  // String dropdownvalue = 'Notes';

  // List of items in our dropdown menu
  List<String> _firstDropdownOptions = [
    'Notes',
    'Clothes',
    'Footwear',
    'Stationary',
    'Gadgets',
  ];

  // Define the options for the second dropdown, based on the selected value of the first dropdown
  Map<String, List<String>> _secondDropdownOptions = {
    'Notes': ['DSA', 'DBMS', 'Operating System', 'Java'],
    'Clothes': ['Formal', 'Ethnic', 'Casual'],
    'Footwear': ['Sports', 'Formal', 'Casual'],
    'Stationary': ['Notebook', 'Calculator', 'Pen'],
    'Gadgets': ['Earphone', 'Charger', 'Speaker','Laptop'],
  };

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
  ) async {
    FocusScope.of(context).unfocus();
    if (rentImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Upload Image')),
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
      'majorcategory': firstDropdownValue,
      'subcategory': secondDropdownValue,
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
      'majorcategory': firstDropdownValue,
      'subcategory': secondDropdownValue,
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
    TextEditingController _desController = TextEditingController();

    // Check if the text form field is empty

    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[300],
        toolbarHeight: 60,
        title: Text('Upload Section'),
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
                            height: myHeight * 0.2,
                            width: myWidth * 0.5,
                            decoration: BoxDecoration(
                              image: _image != null
                                  ? DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.cover,
                                    )
                                  : DecorationImage(
                                      image: AssetImage(
                                          'assets/images/upload.png'),
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
                        onChanged: (value) {
                          setState(() {
                            _titleText = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Enter Title",
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
                          hintText: 'Title',
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Pleas enter valid email address';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _descriptionText = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter Description',
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
                          hintText: 'Description',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _rentalPrice = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Enter Price",
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
                          hintText: 'Price',
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Pleas Price';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   width: myWidth,
                      //   child: DropdownButton(
                      //     // hint: Text('Select Category'),
                      //     // Initial Value
                      //     value: dropdownvalue,
                      //
                      //     // Down Arrow Icon
                      //     icon: const Icon(Icons.keyboard_arrow_down),
                      //
                      //     // Array list of items
                      //     items: items.map((String items) {
                      //       return DropdownMenuItem(
                      //         value: items,
                      //         child: Text(items,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                      //       );
                      //     }).toList(),
                      //     // After selecting the desired option,it will
                      //     // change button value to selected value
                      //     onChanged: (String? newValue) {
                      //       setState(() {
                      //         dropdownvalue = newValue!;
                      //       });
                      //     },
                      //   ),
                      // ),

                      SizedBox(
                        height: 20,
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

                      MaterialButton(
                        onPressed: () {
                          if (_image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Choose Image')),
                            );
                          } else if (_selectedFirstValue == null ||
                              _selectedSecondValue == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Choose Category')),
                            );
                          } else if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );

                            _uploadToFirebase(
                                _image!,
                                _titleText,
                                _descriptionText,
                                _rentalPrice,
                                _selectedFirstValue!,
                                _selectedSecondValue!);
                            setState(() {
                              _image = null;
                              _selectedFirstValue = null;
                              _selectedSecondValue = null;
                            });
                          }
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
