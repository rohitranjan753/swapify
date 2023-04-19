import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'browse_category_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List categoryIcon = [
    LineIcons.book,
    LineIcons.tShirt,
    LineIcons.shoePrints,
    LineIcons.pencilRuler,
    LineIcons.laptop,
    LineIcons.bed
  ];

  List categoryName = ["Notes", "Clothes", "Footwear", "Stationary", "Gadgets","Mattress"];
  int clicked = 0;

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: ListView.builder(
            itemCount: categoryIcon.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BrowseCategoryScreen(
                              index: index,
                              categoryName: categoryName,
                            )));
                  },
                  child: categorySingleRow(index));
            },
          ),
        ),
      ),
    );
  }

  Widget categorySingleRow(int index) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: myHeight*0.15,
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blueAccent, Colors.tealAccent]),
        ),
        child: Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(categoryIcon[index],size: 50,),
                ),
                Text(
                  categoryName[index],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // color: clicked == index ? Colors.white : Colors.blueAccent,
                      fontSize: 25),
                ),
              ],
            )),
      ),
    );
  }
}
