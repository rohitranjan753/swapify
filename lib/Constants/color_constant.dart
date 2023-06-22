import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color.fromARGB(255, 147, 207, 255);
  static const Color secondaryColor = Color(0xFFFF4081);
  static const Color appbarColor = Color(0xaa837afb);
  static const Color buttonColor = Color(0xaaa69f74);
  static const Color backgroundColor = Color(0xFFF6F1F1);
  static const Color tPrimaryColour = Color(0xFFFFE400);
  // static const Color tSecondaryColour = Color(0xFF272727);
  static const Color tSecondaryColour = Colors.deepPurple;
  static const Color navBarBackgroundColour = Color(0xFFEAC8FF);
// Define more colors here if needed
}

class categoryList{
  List majorCategoryName = ["Notes", "Clothes", "Footwear", "Stationary", "Gadgets"];

  List<String> firstDropdownOptions = [
    'Notes',
    'Clothes',
    'Footwear',
    'Stationary',
    'Gadgets',
  ];

  // Define the options for the second dropdown, based on the selected value of the first dropdown
  Map<String, List<String>> secondDropdownOptions = {
    'Notes': ['DSA', 'DBMS', 'Operating System', 'Java'],
    'Clothes': ['Formal', 'Ethnic', 'Casual'],
    'Footwear': ['Sports', 'Formal', 'Casual'],
    'Stationary': ['Notebook', 'Calculator', 'Pen'],
    'Gadgets': ['Earphone', 'Charger', 'Speaker','Laptop','Keyboard'],
  };
}


