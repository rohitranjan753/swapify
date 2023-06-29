import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vbuddyproject/BuyBuilderDirectory/buy_page.dart';
import 'package:vbuddyproject/Chat/chatpage.dart';
import 'package:vbuddyproject/Constants/image_string.dart';
import 'package:vbuddyproject/Constants/sizes.dart';
import 'package:vbuddyproject/HomePageDir/browse_category_screen.dart';
import 'package:vbuddyproject/HomePageDir/category_screen.dart';
import 'package:vbuddyproject/RentSectionDirectory/rent_home_screen.dart';
import 'package:vbuddyproject/SearchPageDir/SearchPage.dart';
import 'package:vbuddyproject/Constants/color_constant.dart';

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
      userImage = userDoc.get('userimage');
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

  List categoryName = [
    "Notes",
    "Clothes",
    "Footwear",
    "Stationary",
    "Gadgets",
  ];


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
                height: myHeight * 0.11,
                // height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius:40,
                            backgroundImage: NetworkImage(userImage),
                          ),
                          // Container(
                          //   height: 100.0,
                          //   width: 55.0,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(500),
                          //     image: DecorationImage(
                          //         image: NetworkImage(userImage),
                          //         fit: BoxFit.cover),
                          //   ),
                          // ),
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
                                    letterSpacing: textLetterSpacingValue - 1,
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatPage()));
                        },
                        child: Icon(
                          Icons.chat,
                          color: mainUiColour,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                height: myHeight * 0.12,
                width: myWidth,
                child: ListView.builder(
                    itemCount: categoryIcon.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
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
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommended",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage()));
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //BUY
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
                                    image: AssetImage(homepageBuy),
                                    fit: BoxFit.cover),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      bottom: 10,
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'BUY',
                                            style: TextStyle(
                                              fontWeight: buttonTextWeight,
                                              letterSpacing:
                                                  textLetterSpacingValue,
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

                      //RENT
                      Padding(
                        padding: const EdgeInsets.all(40.0),
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
                                  image: AssetImage(homepageRent),
                                  fit: BoxFit.cover),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    bottom: 10,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'RENT',
                                          style: TextStyle(
                                            letterSpacing:
                                                textLetterSpacingValue,
                                            fontWeight: buttonTextWeight,
                                            color: Colors.black,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget categorySingleRow(int index) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Icon(
            categoryIcon[index],
            size: 50,
            color: mainUiColour,
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
    );
  }
}
