import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vbuddyproject/Chat/chatScreenOld.dart';
import 'package:vbuddyproject/Chat/chat_screen.dart';
import 'package:vbuddyproject/widget/back_btn_design.dart';

class SelectedSearchPage extends StatefulWidget {
  final DocumentSnapshot item;

  SelectedSearchPage({required this.item});

  @override
  State<SelectedSearchPage> createState() => _SelectedSearchPageState();
}

// class _SelectedSearchPageState extends State<SelectedSearchPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   void checkChatAndOpenScreen(String currentUser, String otherUser) {
//     FirebaseFirestore.instance
//         .collection('chats')
//         .where('users', arrayContainsAny: [currentUser, otherUser])
//         .get()
//         .then((querySnapshot) {
//       if (querySnapshot.docs.isNotEmpty) {
//         // Chat exists, open chat screen
//         String chatId = querySnapshot.docs[0].id;
//         openChatScreen(chatId);
//       } else {
//         // Chat doesn't exist, create a new chat ID and store it in Firestore
//         createChatAndOpenScreen(currentUser, otherUser);
//       }
//     });
//   }
//
//   void createChatAndOpenScreen(String currentUser, String otherUser) {
//     FirebaseFirestore.instance
//         .collection('chats')
//         .add({
//       'users': [currentUser, otherUser]
//     })
//         .then((docRef) {
//       String chatId = docRef.id;
//       // Store the chat ID in Firestore
//       // (You can also store additional chat details if needed)
//
//       // Open the chat screen and pass the chat ID
//       openChatScreen(chatId);
//     });
//   }
//
//
//   void openChatScreen(String chatId) {
//     Navigator.push(context, MaterialPageRoute(builder: (contetx)=>ChatScreen(chatId: chatId)));
//   }
//
//
//   void _sendEmail() async {
//     final Uri params = Uri(
//       scheme: 'mailto',
//       path: widget.item['creatormail'],
//       query: 'subject=Hey%20I%20am%20interested&body=Let''\s%20us%20connect%20',
//     );
//     String url = params.toString();
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     Timestamp timestamp = widget.item['createdAt'];
//     DateTime date = timestamp.toDate();
//
// // Format the DateTime object as a string using the DateFormat class from the intl package
//     String formattedDate = DateFormat('dd-MM-yyyy').format(date);
//
//     double myHeight = MediaQuery.of(context).size.height;
//     double myWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             // Do something when the menu icon is pressed
//             Navigator.pop(context);
//           },
//         ),
//         backgroundColor: Colors.cyan[300],
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(30),
//               bottomLeft: Radius.circular(30)),
//         ),
//         // title: Text(widget.item['creatorname']),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           // color: Color.fromRGBO(255, 248, 238, 10),
//           height: myHeight,
//           width: myWidth,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Container(
//                   height: myHeight * 0.4,
//                   // width: myWidth * 0.3,
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           blurRadius: 7,
//                           spreadRadius: 3,
//                           offset: Offset(0, 5)),
//                     ],
//                     image: DecorationImage(
//                         image: NetworkImage(widget.item['imageUrl']),
//                         fit: BoxFit.cover),
//                   ),
//                 ),
//               ),
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 20,
//                       bottom: 30,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           child: Row(
//                             children: [
//                               // Icon(
//                               //   Icons.label,
//                               //   size: myWidth * 0.050,
//                               // ),
//                               Text(
//                                 widget.item['title'],
//                                 style: TextStyle(
//                                     fontSize: 30, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: myHeight * 0.03,
//                         ),
//                         Container(
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.category,
//                                 size: myWidth * 0.050,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 5),
//                                 child: Text(
//                                   "Category",
//                                   style: TextStyle(
//                                       fontSize: 22, fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 30),
//                           child: Text(
//                             widget.item['subcategory'] +
//                                 "(" +
//                                 widget.item['majorcategory'] +
//                                 ")",
//                             style: TextStyle(
//                               fontSize: 19,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: myHeight * 0.02,
//                         ),
//                         Container(
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.description,
//                                 size: myWidth * 0.050,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 5),
//                                 child: Text(
//                                   "Description",
//                                   style: TextStyle(
//                                       fontSize: 22, fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 30),
//                           child: Text(
//                             widget.item['description'],
//                             style: TextStyle(
//                               fontSize: 19,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: myHeight * 0.02,
//                         ),
//                         Container(
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.person,
//                                 size: myWidth * 0.050,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 5),
//                                 child: Text(
//                                   "Uploaded By",
//                                   style: TextStyle(
//                                       fontSize: 22, fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 30),
//                           child: Text(
//                             widget.item['creatorname'],
//                             style: TextStyle(
//                               fontSize: 19,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: myHeight * 0.02,
//                         ),
//                         Container(
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.access_time_filled,
//                                 size: myWidth * 0.050,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 5),
//                                 child: Text(
//                                   "Uploaded On",
//                                   style: TextStyle(
//                                       fontSize: 22, fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 30),
//                           child: Text(
//                             formattedDate,
//                             style: TextStyle(
//                               fontSize: 19,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: myHeight * 0.02,
//                         ),
//                         Container(
//                           child: Row(
//                             children: [
//                               LineIcon.indianRupeeSign(
//                                 size: myWidth * 0.050,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 5),
//                                 child: Text(
//                                   "Price",
//                                   style: TextStyle(
//                                       fontSize: 22, fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 30),
//                           child: widget.item['category'].toString() == "sell" ?Text(
//                             "₹${widget.item['price']}",
//                             style: TextStyle(fontSize: 19),
//                           ) : Text(
//                             "₹${widget.item['price']} / 12Hrs",
//                             style: TextStyle(fontSize: 19),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               _auth.currentUser!.uid == widget.item['createdby'] ? Padding(padding: EdgeInsets.all(0)):
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 5),
//                 child: MaterialButton(
//                   onPressed: (){checkChatAndOpenScreen(_auth.currentUser!.uid,widget.item['createdby']);},
//                   minWidth: myWidth*0.5,
//                   height: 60,
//                   color: Colors.cyan,
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50)),
//                   child: Text(
//                     "SEND EMAIL",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//
//     );
//   }
// }

//Updated One final
class _SelectedSearchPageState extends State<SelectedSearchPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void checkChatAndOpenScreen(String currentUser, String otherUser) {
    FirebaseFirestore.instance
        .collection('chats')
        .where('users', arrayContainsAny: [currentUser, otherUser])
        .get()
        .then((querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            // Chat exists, open chat screen
            String chatId = querySnapshot.docs[0].id;
            openChatScreen(chatId);
          } else {
            // Chat doesn't exist, create a new chat ID and store it in Firestore
            createChatAndOpenScreen(currentUser, otherUser);
          }
        });
  }

  void createChatAndOpenScreen(String currentUser, String otherUser) {
    FirebaseFirestore.instance.collection('chats').add({
      'users': [currentUser, otherUser]
    }).then((docRef) {
      String chatId = docRef.id;
      // Store the chat ID in Firestore
      // (You can also store additional chat details if needed)

      // Open the chat screen and pass the chat ID
      openChatScreen(chatId);
    });
  }

  void openChatScreen(String chatId) {
    Navigator.push(context,
        MaterialPageRoute(builder: (contetx) => ChatScreen(chatId: chatId)));
  }

  void _sendEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: widget.item['creatormail'],
      query:
          'subject=Hey%20I%20am%20interested&body=Let' '\s%20us%20connect%20',
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    Timestamp timestamp = widget.item['createdAt'];
    DateTime date = timestamp.toDate();
    double myScale = 1.0;
    double previousScale = 1.0;

// Format the DateTime object as a string using the DateFormat class from the intl package
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);

    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const backiconButtonDesign(),

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
        ),
        // title: Text(widget.item['creatorname']),
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: Color.fromRGBO(255, 248, 238, 10),

          width: myWidth,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(

                  elevation: 10,
                  child: Container(

                    height: myHeight * 0.4,
                    child: PinchZoom(
                      child: Image.network(widget.item['imageUrl']),
                      resetDuration: const Duration(milliseconds: 100),
                      maxScale: 5,
                      onZoomStart: () {
                        print('Start zooming');
                      },
                      onZoomEnd: () {
                        print('Stop zooming');
                      },
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Container(
              //
              //     height: myHeight * 0.4,
              //     child: PinchZoom(
              //       child: Image.network(widget.item['imageUrl']),
              //       resetDuration: const Duration(milliseconds: 100),
              //       maxScale: 5,
              //       onZoomStart: () {
              //         print('Start zooming');
              //       },
              //       onZoomEnd: () {
              //         print('Stop zooming');
              //       },
              //     ),
              //   ),
              // ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      bottom: 30,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              // Icon(
                              //   Icons.label,
                              //   size: myWidth * 0.050,
                              // ),
                              Text(
                                widget.item['title'],
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: myHeight * 0.03,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.category,
                                size: myWidth * 0.050,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Category",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            widget.item['subcategory'] +
                                "(" +
                                widget.item['majorcategory'] +
                                ")",
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: myHeight * 0.02,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.description,
                                size: myWidth * 0.050,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Description",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            widget.item['description'],
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: myHeight * 0.02,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: myWidth * 0.050,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Uploaded By",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        user!.uid == widget.item["createdby"]
                            ? Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(
                                  'You',
                                  style: TextStyle(fontSize: 19),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(
                                 widget.item["creatorname"],
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: myHeight * 0.02,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time_filled,
                                size: myWidth * 0.050,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Uploaded On",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: myHeight * 0.02,
                        ),
                        Container(
                          child: Row(
                            children: [
                              LineIcon.indianRupeeSign(
                                size: myWidth * 0.050,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Price",
                                  style: TextStyle(
                                      fontSize: 22),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: widget.item['category'].toString() == "sell"
                              ? Text(
                                  "₹${widget.item['price']}",
                                  style: TextStyle(fontSize: 19),
                                )
                              : Text(
                                  "₹${widget.item['price']} / 6Hrs",
                                  style: TextStyle(fontSize: 19),
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              _auth.currentUser!.uid == widget.item['createdby']
                  ? Padding(padding: EdgeInsets.all(0))
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: MaterialButton(
                        onPressed: () {
                          checkChatAndOpenScreen(
                              _auth.currentUser!.uid, widget.item['createdby']);
                        },
                        minWidth: myWidth * 0.5,
                        height: 60,
                        color: Colors.cyan,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "CHAT",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}



// class _SelectedSearchPageState extends State<SelectedSearchPage> {
//   bool _isImageZoomed = false;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   void checkChatAndOpenScreen(String currentUser, String otherUser) {
//     FirebaseFirestore.instance
//         .collection('chats')
//         .where('users', arrayContainsAny: [currentUser, otherUser])
//         .get()
//         .then((querySnapshot) {
//           if (querySnapshot.docs.isNotEmpty) {
//             // Chat exists, open chat screen
//             String chatId = querySnapshot.docs[0].id;
//             openChatScreen(chatId);
//           } else {
//             // Chat doesn't exist, create a new chat ID and store it in Firestore
//             createChatAndOpenScreen(currentUser, otherUser);
//           }
//         });
//   }
//
//   void createChatAndOpenScreen(String currentUser, String otherUser) {
//     FirebaseFirestore.instance.collection('chats').add({
//       'users': [currentUser, otherUser]
//     }).then((docRef) {
//       String chatId = docRef.id;
//       // Store the chat ID in Firestore
//       // (You can also store additional chat details if needed)
//
//       // Open the chat screen and pass the chat ID
//       openChatScreen(chatId);
//     });
//   }
//
//   void openChatScreen(String chatId) {
//     Navigator.push(context,
//         MaterialPageRoute(builder: (contetx) => ChatScreen(chatId: chatId)));
//   }
//
//   void _sendEmail() async {
//     final Uri params = Uri(
//       scheme: 'mailto',
//       path: widget.item['creatormail'],
//       query:
//           'subject=Hey%20I%20am%20interested&body=Let' '\s%20us%20connect%20',
//     );
//     String url = params.toString();
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Timestamp timestamp = widget.item['createdAt'];
//     DateTime date = timestamp.toDate();
//
// // Format the DateTime object as a string using the DateFormat class from the intl package
//     String formattedDate = DateFormat('dd-MM-yyyy').format(date);
//
//     double myHeight = MediaQuery.of(context).size.height;
//     double myWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             // Do something when the menu icon is pressed
//             Navigator.pop(context);
//           },
//         ),
//         backgroundColor: Colors.cyan[300],
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(30),
//               bottomLeft: Radius.circular(30)),
//         ),
//         // title: Text(widget.item['creatorname']),
//       ),
//       body: ListView.builder(
//           itemCount: 1,
//           itemBuilder: (BuildContext context, int index) {
//             return Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
//               child: Column(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _isImageZoomed = !_isImageZoomed;
//                       });
//                     },
//                     child: Container(
//                       height: _isImageZoomed ? myHeight : myHeight * 0.4,
//                       decoration: BoxDecoration(
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               blurRadius: 7,
//                               spreadRadius: 3,
//                               offset: Offset(0, 5)),
//                         ],
//                         image: DecorationImage(
//                             image: NetworkImage(widget.item['imageUrl']),
//                             fit: BoxFit.cover),
//                       ),
//                       child: _isImageZoomed
//                           ? PhotoView(
//                               imageProvider:
//                                   NetworkImage(widget.item['imageUrl']),
//                               minScale: PhotoViewComputedScale.contained * 0.8,
//                               maxScale: PhotoViewComputedScale.covered * 2.0,
//                             )
//                           : null,
//                     ),
//                   ),
//                   Container(
//                     // color: Color.fromRGBO(255, 248, 238, 10),
//                     height: myHeight,
//                     width: myWidth,
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(20.0),
//                         ),
//                         Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 left: 20,
//                                 bottom: 30,
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     child: Row(
//                                       children: [
//                                         // Icon(
//                                         //   Icons.label,
//                                         //   size: myWidth * 0.050,
//                                         // ),
//                                         Text(
//                                           widget.item['title'],
//                                           style: TextStyle(
//                                               fontSize: 30,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: myHeight * 0.03,
//                                   ),
//                                   Container(
//                                     child: Row(
//                                       children: [
//                                         Icon(
//                                           Icons.category,
//                                           size: myWidth * 0.050,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 5),
//                                           child: Text(
//                                             "Category",
//                                             style: TextStyle(
//                                                 fontSize: 22,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 30),
//                                     child: Text(
//                                       widget.item['subcategory'] +
//                                           "(" +
//                                           widget.item['majorcategory'] +
//                                           ")",
//                                       style: TextStyle(
//                                         fontSize: 19,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: myHeight * 0.02,
//                                   ),
//                                   Container(
//                                     child: Row(
//                                       children: [
//                                         Icon(
//                                           Icons.description,
//                                           size: myWidth * 0.050,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 5),
//                                           child: Text(
//                                             "Description",
//                                             style: TextStyle(
//                                                 fontSize: 22,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 30),
//                                     child: Text(
//                                       widget.item['description'],
//                                       style: TextStyle(
//                                         fontSize: 19,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: myHeight * 0.02,
//                                   ),
//                                   Container(
//                                     child: Row(
//                                       children: [
//                                         Icon(
//                                           Icons.person,
//                                           size: myWidth * 0.050,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 5),
//                                           child: Text(
//                                             "Uploaded By",
//                                             style: TextStyle(
//                                                 fontSize: 22,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 30),
//                                     child: Text(
//                                       widget.item['creatorname'],
//                                       style: TextStyle(
//                                         fontSize: 19,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: myHeight * 0.02,
//                                   ),
//                                   Container(
//                                     child: Row(
//                                       children: [
//                                         Icon(
//                                           Icons.access_time_filled,
//                                           size: myWidth * 0.050,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 5),
//                                           child: Text(
//                                             "Uploaded On",
//                                             style: TextStyle(
//                                                 fontSize: 22,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 30),
//                                     child: Text(
//                                       formattedDate,
//                                       style: TextStyle(
//                                         fontSize: 19,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: myHeight * 0.02,
//                                   ),
//                                   Container(
//                                     child: Row(
//                                       children: [
//                                         LineIcon.indianRupeeSign(
//                                           size: myWidth * 0.050,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 5),
//                                           child: Text(
//                                             "Price",
//                                             style: TextStyle(
//                                                 fontSize: 22,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 30),
//                                     child: widget.item['category'].toString() ==
//                                             "sell"
//                                         ? Text(
//                                             "₹${widget.item['price']}",
//                                             style: TextStyle(fontSize: 19),
//                                           )
//                                         : Text(
//                                             "₹${widget.item['price']} / 12Hrs",
//                                             style: TextStyle(fontSize: 19),
//                                           ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                         _auth.currentUser!.uid == widget.item['createdby']
//                             ? Padding(padding: EdgeInsets.all(0))
//                             : Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 5),
//                                 child: MaterialButton(
//                                   onPressed: () {
//                                     checkChatAndOpenScreen(
//                                         _auth.currentUser!.uid,
//                                         widget.item['createdby']);
//                                   },
//                                   minWidth: myWidth * 0.5,
//                                   height: 60,
//                                   color: Colors.cyan,
//                                   elevation: 5,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(50)),
//                                   child: Text(
//                                     "SEND EMAIL",
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                 ),
//                               ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },),
//     );
//   }
// }

