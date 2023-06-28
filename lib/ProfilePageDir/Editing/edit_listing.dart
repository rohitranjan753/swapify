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

class EditListing extends StatefulWidget {
  final DocumentSnapshot item;

  const EditListing({required this.item});


  @override
  State<EditListing> createState() => _EditListingState();
}

class _EditListingState extends State<EditListing> {
  TextEditingController _itemTitleController  = TextEditingController();
  TextEditingController _itemDescriptionController  = TextEditingController();
  TextEditingController _itemPriceController  = TextEditingController();


  bool _isLoading = false;
  String _itemTitle = '';
  String _itemDescription = '';
  String _itemPrice = '';
  String _userimage='';
  File? _image;

  Future<void> _uploadToFirebase(
      File? userImage,
      String itemTitle,
      String itemDescription,
      String itemPrice,
      ) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Updating! Please wait',
          style: TextStyle(
            color: Colors.black,
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

    if (userImage != null) {
      String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();

      final Reference storageRef =
      FirebaseStorage.instance.ref().child('images');
      final taskSnapshot =
      await storageRef.child('${uniqueId}.jpg').putFile(userImage);
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('all_section')
          .doc(widget.item.id)
          .update({
        'imageUrl': downloadUrl,
      });
    }

    await Future.delayed(Duration(seconds: 2)); // Adding a 2-second delay

    await FirebaseFirestore.instance
        .collection('all_section')
        .doc(widget.item.id)
        .update({
      'title': itemTitle,
      'description': itemDescription,
      'price': itemPrice,
    });

    setState(() {
      _isLoading = false;
    });




    // Update the text fields with the new values
    setState(() {
      _itemTitle = itemTitle;
      _itemTitleController.text = _itemTitle;
    });

    setState(() {
      _itemDescription = itemDescription;
      _itemDescriptionController.text = _itemDescription;
    });

    setState(() {
      _itemPrice = itemPrice;
      _itemPriceController.text = _itemPrice;
    });

    Fluttertoast.showToast(
      msg: 'Information updated successfully!',
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
  void getData() async {
    setState(() {
      _itemTitle = widget.item['title'].toString();
      _itemTitleController.text  =_itemTitle;

      _itemDescription = widget.item['description'].toString();
      _itemDescriptionController.text  =_itemDescription;

      _itemPrice = widget.item['price'].toString();
      _itemPriceController.text  =_itemPrice;
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
        title: Text('Edit Listing'),
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
                    borderRadius: BorderRadius.circular(20),
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
                        image: NetworkImage(widget.item['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Align(
                  alignment: Alignment.topLeft,
                  child: Text("Title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              SizedBox(height: 3,),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: _itemTitleController,
                // initialValue: _itemTitle,
                onChanged: (value) {
                  setState(() {
                    _itemTitle = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Enter Title",
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
              SizedBox(height: 20,),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text("Description",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              TextFormField(
                maxLength: 50,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                controller: _itemDescriptionController,
                // initialValue: _itemTitle,
                onChanged: (value) {
                  setState(() {
                    _itemDescription = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Enter Description",

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
              SizedBox(height: 10,),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text("Price",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _itemPriceController,
                // initialValue: _itemTitle,
                onChanged: (value) {
                  setState(() {
                    _itemPrice = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Enter Price",
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
                height: 30,
              ),



              // First Dropdown

              MaterialButton(
                onPressed: () {
                  if (_itemTitleController.text.isEmpty ||
                      _itemDescriptionController.text.isEmpty ||
                      _itemPriceController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Field is empty.'),
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
                    if (_image != null) {
                      _uploadToFirebase(
                        _image!,
                        _itemTitleController.text,
                        _itemDescriptionController.text,
                        _itemPriceController.text,
                      );
                    } else {
                      // Handle the case when the image is not changed
                      _uploadToFirebase(
                        null, // Pass null if image is not changed
                        _itemTitleController.text,
                        _itemDescriptionController.text,
                        _itemPriceController.text,
                      );
                    }
                  }
                },
                minWidth: double.infinity,
                height: 60,
                color: Colors.deepPurple,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'SUBMIT',
                  style: TextStyle(
                    fontWeight: buttonTextWeight,
                    letterSpacing: textLetterSpacingValue,
                    fontSize: 18,
                    color: Colors.white,
                  ),
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
