import 'package:flutter/material.dart';


//Main Colour
const mainUiColour = Colors.deepPurple;
const primaryColour = Colors.deepPurple;
const navBarBackgroundColour = Color(0xFFF4DAFF);


const chatBubbleCurrentUserColor = Color(0xFFEAC8FF);


//Button Colour
const buttonColour = Colors.deepPurple;
const editButtonColour = Color(0xFFC45EFF);


//button text
const buttonTextColor = Colors.white;

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


