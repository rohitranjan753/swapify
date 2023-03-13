import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vbuddyproject/AddPageDir/add_page.dart';
import 'package:vbuddyproject/BuyBuiderDirectory/buy_page.dart';
import 'package:vbuddyproject/Components/single_item_homepage.dart';
import 'package:vbuddyproject/HomePageDir/category_screen.dart';
import 'package:vbuddyproject/HomePageDir/home_category_horizontal_row.dart';
import 'package:vbuddyproject/Model/homepage_single_row_model.dart';
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
    Icons.car_rental,
    Icons.home_filled,
    Icons.phone_android,
    Icons.directions_bike,
    Icons.tv
  ];

  List categoryName = ["Car", "Home", "Phone", "Bike", "TV"];

  // List category = [
  //   "Notes",
  //   "CLothes",
  //   "Stationary",
  //   "Mattress",
  //   "Sports",
  //   "Grocery"
  // ];

  int clicked = 0;

  // String myName = '';

  // String myUsername='';
  // Future<void> _getCurrentUserName() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   String uid = user!.uid;
  //
  //  await FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(uid)
  //       .get()
  //       .then((snapshot) {
  //     setState(() {
  //       // myName = (snapshot.data() as Map<String, dynamic>)['name'].toString(); // change this
  //       myUsername = (snapshot.data() as Map<String, dynamic>)['username'].toString(); // and this
  //       print(myUsername);
  //     });
  //   });
  // }

  @override
  void initState() {
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
    //   await loadJson();
    //
    // });
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
                                    fontSize: 20, color: Colors.grey[600],fontWeight: FontWeight.bold),
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

              // Scroll Row(list)
              SingleChildScrollView(
                padding: EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => RegistrationScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Icon(
                              LineIcons.book,
                              size: 50,
                              color: Colors.blue,
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
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Icon(
                            LineIcons.tShirt,
                            size: 50,
                            color: Colors.blue,
                          ),
                          Text(
                            "Clothes",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Icon(
                            LineIcons.shoePrints,
                            size: 50,
                            color: Colors.blue,
                          ),
                          Text(
                            "Footwear",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Icon(
                            LineIcons.pencilRuler,
                            size: 50,
                            color: Colors.blue,
                          ),
                          Text(
                            "Stationary",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Icon(
                            LineIcons.laptop,
                            size: 50,
                            color: Colors.blue,
                          ),
                          Text(
                            "Gadgets",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
                          onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BuyPage()));
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
                                    image: AssetImage(
                                      'assets/profile/buy1.jpg'
                                    ),
                                    fit: BoxFit.cover),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20, top: 10),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: myHeight * 0.06,
                                        width: myWidth * 0.12,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Color.fromARGB(255, 40, 93, 116)
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
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
                                    image: AssetImage(
                                        'assets/profile/rent1.jpg'
                                    ),
                                    fit: BoxFit.cover),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20, top: 10),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: myHeight * 0.06,
                                        width: myWidth * 0.12,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Color.fromARGB(255, 40, 93, 116)
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                )
              )

              // Expanded(
              //     child: ListView.builder(
              //       itemCount: placeList.length,
              //       itemBuilder: (context, index) {
              //         return HomePageSingleItem(
              //           index: index,
              //           item: placeList,
              //         );
              //       },
              //     ))
            ],
          ),
        ),
      ),
    );
  }

  // Widget categoryuWidget(int index) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 5),
  //     child: GestureDetector(
  //       onTap: () {
  //           if(index == 0){
  //             Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
  //           }
  //           else if(index ==1) {
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => AddPage()));
  //           };
  //         setState(() {
  //           clicked = index;
  //         });
  //       },
  //       child: Container(
  //         padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
  //         decoration: clicked == index
  //             ? BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //           gradient: LinearGradient(
  //               begin: Alignment.topLeft,
  //               end: Alignment.bottomRight,
  //               colors: [Colors.blueAccent, Colors.lightBlueAccent]),
  //         )
  //             : BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //           color: Colors.white,
  //         ),
  //         child: Center(
  //             child: Text(
  //               category[index],
  //               style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   color: clicked == index ? Colors.white : Colors.blueAccent,
  //                   fontSize: 15),
  //             )),
  //       ),
  //       // child: Container(
  //       //   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
  //       //   decoration:
  //       //   clicked==index?
  //       //   BoxDecoration(
  //       //     borderRadius: BorderRadius.circular(10),
  //       //     gradient: LinearGradient(
  //       //         begin: Alignment.topLeft,
  //       //         end: Alignment.bottomRight,
  //       //         colors: [Colors.blueAccent, Colors.lightBlueAccent]),
  //       //   ) : BoxDecoration(
  //       //     borderRadius: BorderRadius.circular(10),
  //       //     color: Colors.white,
  //       //   ),
  //       //   child: Center(
  //       //       child: Text(
  //       //     category[index],
  //       //     style: TextStyle(
  //       //         fontWeight: FontWeight.bold, color: clicked==index? Colors.white : Colors.blueAccent, fontSize: 15),
  //       //   )),
  //       // ),
  //     ),
  //   );
  // }
  //
  // List myData = [];
  //
  // List<HomeSingleRowModel> placeList = [];
  //
  // loadJson() async {
  //   String data = await rootBundle.loadString('assets/json/data.json');
  //
  //   setState(() {
  //     myData = json.decode(data);
  //     placeList = myData.map((e) => HomeSingleRowModel.fromJson(e)).toList();
  //     placeList = placeList;
  //   });
  // }

}
