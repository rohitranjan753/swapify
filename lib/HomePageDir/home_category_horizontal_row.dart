import 'package:flutter/material.dart';

class CategoryHorizontalRow extends StatefulWidget {
  const CategoryHorizontalRow({Key? key}) : super(key: key);

  @override
  State<CategoryHorizontalRow> createState() => _CategoryHorizontalRowState();
}

class _CategoryHorizontalRowState extends State<CategoryHorizontalRow> {
  List categoryIcon = [
    Icons.directions_bike,
    Icons.home_filled,
    Icons.phone_android,
    Icons.people,
    Icons.mail,
    Icons.notifications_none
  ];

  List categoryName = [
    "Bike",
    "Home",
    "Phone",
    "People",
    "Mail",
    "Notification"
  ];
  int clicked = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            itemCount: categoryIcon.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return categorySingleRow(index);
            },
          );
  }

  Widget categorySingleRow(int index) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          if (index == 0) {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
          } else if (index == 1) {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => LoginScreen()));
          }
          ;
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Icon(
                categoryIcon[index],
                size: 50,
              ),
              Text(
                categoryName[index],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
