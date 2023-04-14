import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vbuddyproject/AddPageDir/RentDir/rent_page.dart';
import 'package:vbuddyproject/BuyBuiderDirectory/buy_page.dart';
import 'package:vbuddyproject/BuyBuiderDirectory/buy_page_new.dart';
import 'package:vbuddyproject/BuyBuiderDirectory/selected_buy_page.dart';
import 'package:vbuddyproject/HomePageDir/category_screen.dart';
import 'package:vbuddyproject/RentSectionDirectory/rent_home_screen.dart';
import 'package:vbuddyproject/SearchPageDir/SearchPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = '';
  String userImage = '';
  void getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    setState(() {
      username = userDoc.get('username').toString();
      print(username);
    });
  }

  List categoryIcon = [
    LineIcons.book,
    LineIcons.tShirt,
    LineIcons.shoePrints,
    LineIcons.pencilRuler,
    LineIcons.laptop,
  ];

  List categoryName = ["Notes", "Clothes", "Footwear", "Stationary", "Gadgets"];

  int clicked = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: myHeight,
          width: myWidth,
          child: Column(
            children: [
              Container(
                height: myHeight * 0.1,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: myHeight * 0.06,
                            width: myWidth * 0.12,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 203, 172, 76),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/proctor3.jpg'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            width: myWidth * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Hello there",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                username,
                                // FirebaseAuth.instance.currentUser!.displayName!,
                                // 'Username comment',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.blue[300],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: myHeight * 0.1,
                width: myWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: myHeight * 0.05,
                      width: myWidth * 0.75,
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(40)),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search For Product...',
                          hintStyle: TextStyle(color: Colors.grey),
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 54, 54, 54),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: myHeight * 0.05,
                      width: myWidth * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.red, Colors.yellowAccent]),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/proctor3.jpg',
                          height: myHeight * 0.025,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Browse Categories",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryScreen()));
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[600]),
                        )),
                  ],
                ),
              ),
              Container(
                height: myHeight * 0.1,
                width: myWidth,
                child: ListView.builder(
                    itemCount: categoryIcon.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return categorySingleRow(index);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommended",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BuyPage()));
                        },
                        child: Container(
                            height: myHeight * 0.4,
                            // width: myWidth * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 7,
                                    spreadRadius: 3,
                                    offset: Offset(0, 5)),
                              ],
                              image: DecorationImage(
                                  image: AssetImage('assets/profile/buy1.jpg'),
                                  fit: BoxFit.cover),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 20, top: 10),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      height: myHeight * 0.06,
                                      width: myWidth * 0.12,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color:
                                              Color.fromARGB(255, 40, 93, 116)
                                                  .withOpacity(0.5)),
                                      child: Icon(
                                        Icons.bookmark_add_rounded,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    bottom: 30,
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'BUY',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RentHomeScreen()));
                        },
                        child: Container(
                            height: myHeight * 0.4,
                            // width: myWidth * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 7,
                                    spreadRadius: 3,
                                    offset: Offset(0, 5)),
                              ],
                              image: DecorationImage(
                                  image: AssetImage('assets/profile/rent1.jpg'),
                                  fit: BoxFit.cover),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 20, top: 10),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      height: myHeight * 0.06,
                                      width: myWidth * 0.12,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color:
                                              Color.fromARGB(255, 40, 93, 116)
                                                  .withOpacity(0.5)),
                                      child: Icon(
                                        Icons.bookmark_add_rounded,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    bottom: 30,
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'RENT',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget categorySingleRow(int index) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectedBuyPage(item: categoryName[index])));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Icon(
                categoryIcon[index],
                size: 50,
                color: Colors.blue,
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
