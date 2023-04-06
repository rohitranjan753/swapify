import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:vbuddyproject/BuyBuiderDirectory/selected_buy_page.dart';

final CollectionReference usersCollection =
FirebaseFirestore.instance.collection('sell_major_section');

class BuyNewPage extends StatefulWidget {
  @override
  State<BuyNewPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyNewPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[100],
        title: Card(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search,color: Colors.black,),
              hintText: '  Search...',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _buildQuery().snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<DocumentSnapshot> searchResults = snapshot.data!.docs;
            return ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot data = searchResults[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedBuyPage(item: data)));
                  },
                  child: Container(
                    height: myHeight*0.4,
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
                          image:
                              NetworkImage(data['imageUrl']),
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
                            data['selltitle'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: myWidth * 0.02,
                                    ),
                                    Text(
                                      "\$${data['sellprice']}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: myHeight * 0.01,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Starting At',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      width: myWidth * 0.03,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 7),
                                      child: Container(
                                        // height: myHeight * 0.06,
                                        // width: myWidth * 0.12,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white.withOpacity(0.2)),
                                        child:
                                          user!.uid == data['createdby'] ? Text('Uploaded By: YOU',style: TextStyle(fontWeight: FontWeight.bold),) : Text("Uploaded By: ${data['creatorname']}"),

                                        ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
  Query _buildQuery() {
    Query searchQuery = usersCollection;

    if (_searchController.text.isNotEmpty) {
      String searchValue = _searchController.text;
      searchQuery = searchQuery.where('selltitle', isGreaterThanOrEqualTo: searchValue);
    }

    return searchQuery;
  }
  @override
  void dispose() {
    super.dispose();
  }

}
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:vbuddyproject/BuyBuiderDirectory/selected_buy_page.dart';
//
// class BuyPage extends StatefulWidget {
//   const BuyPage({Key? key}) : super(key: key);
//
//   @override
//   State<BuyPage> createState() => _BuyPageState();
// }
//
// class _BuyPageState extends State<BuyPage> {
//   // This function retrieves data from the Firebase Firestore
//   Stream<QuerySnapshot> getNestedData() {
//     return FirebaseFirestore.instance
//         .collection('sell_major_section')
//     // .doc(FirebaseAuth.instance.currentUser!.uid)
//     // .collection('sellsection')
//         .snapshots();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double myHeight = MediaQuery.of(context).size.height;
//     double myWidth = MediaQuery.of(context).size.width;
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;
//     final FirebaseStorage storage = FirebaseStorage.instance;
//     final User? user = FirebaseAuth.instance.currentUser;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Buy Section'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: getNestedData(),
//         builder: (BuildContext context,
//             AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//
//           if (!snapshot.hasData) {
//             return Text('Loading...');
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final DocumentSnapshot document = snapshot.data!.docs[index];
//
//                 return GestureDetector(
//                   onTap: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedBuyPage(item: document)));
//                   },
//                   child: Card(
//                     child: Column(
//                       children: [
//                         Image(
//                             image: NetworkImage(document['imageUrl']),
//                             height: myHeight * 0.2,
//                             width: myWidth * 0.7),
//                         ListTile(
//                           title: Text(document['selltitle']),
//                           subtitle: Text(document['sellprice']),
//                           trailing: user!.uid == document['createdby'] ? Text('Uploaded By: YOU',style: TextStyle(fontWeight: FontWeight.bold),) : Text("Uploaded By: ${document['creatorname']}"),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
//
// }
