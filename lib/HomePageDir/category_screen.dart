import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List categoryIcon = [
    Icons.directions_bike,
    Icons.home_filled,
    Icons.phone_android,
    Icons.people,
    Icons.mail,
    Icons.notifications_none
  ];

  List categoryName = ["Bike", "Home", "Phone", "People", "Mail","Notification"];
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
              return categorySingleRow(index);
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
      child: GestureDetector(
        onTap: () {
          if(index == 0){
            // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
          }
          else if(index ==1) {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => LoginScreen()));
          };
        },
        child: Container(
          height: myHeight*0.15,
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blueAccent, Colors.lightBlueAccent]),
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

      ),
    );
  }
}
