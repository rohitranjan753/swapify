import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CategoryHorizontalRow extends StatelessWidget {
  final int? index;
  CategoryHorizontalRow({this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Icon(
              LineIcons.book,
              size: 50,
              color: Color(0xfffddff9),
            ),
            Text(
              "Notes",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
