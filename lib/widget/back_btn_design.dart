import 'package:flutter/material.dart';

class backiconButtonDesign extends StatelessWidget {
  const backiconButtonDesign({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        // Do something when the menu icon is pressed
        Navigator.pop(context);
      },
    );
  }
}