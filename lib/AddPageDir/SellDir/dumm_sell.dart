import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Image'),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[300],
            image: _image != null
                ? DecorationImage(
              image: FileImage(_image!),
              fit: BoxFit.cover,
            )
                : null,
          ),
          child: _image == null
              ? Center(
            child: IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          )
              : null,
        ),
      ),
    );
  }
}
