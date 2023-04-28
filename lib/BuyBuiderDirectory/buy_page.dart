import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vbuddyproject/BuyBuiderDirectory/selected_buy_page.dart';

class BuyPage extends StatefulWidget {
  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(15)
            ),
            height: myHeight*0.05,
            width: myWidth*0.7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                style: TextStyle(
                    fontSize: 18
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.cyan,
                  ),
                  hintText: 'Search...',
                ),
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('sell_major_section')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final documents = snapshot.data!.docs.where((doc) =>
              doc['selltitle'].toString().toLowerCase().contains(searchText.toLowerCase()));
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.75,
            ),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final data = documents.elementAt(index);
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectedBuyPage(item: data)));
                },
                child: Card(
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child:  Image.network(
                            data['imageUrl'],
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 1),
                        child: Text(
                          data['selltitle'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      user!.uid == data["createdby"] ?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 1),
                        child: Text(
                          'Uploaded By: YOU',
                          style: TextStyle(
                              fontSize: 12,fontWeight: FontWeight.bold
                          ),
                        ),
                      ): Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 1),
                        child: Text(
                          "Uploaded By: ${data["creatorname"]}",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "₹${data["sellprice"]}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}







// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:line_icons/line_icon.dart';
// import 'package:vbuddyproject/BuyBuiderDirectory/selected_buy_page.dart';
//
// final CollectionReference usersCollection =
// FirebaseFirestore.instance.collection('sell_major_section');
//
// class BuyPage extends StatefulWidget {
//   @override
//   State<BuyPage> createState() => _BuyPageState();
// }
//
// class _BuyPageState extends State<BuyPage> {
//   TextEditingController _searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     double myHeight = MediaQuery.of(context).size.height;
//     double myWidth = MediaQuery.of(context).size.width;
//     final User? user = FirebaseAuth.instance.currentUser;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.cyan[400],
//         title: Container(
//           decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(
//                 color: Colors.white,
//               ),
//               borderRadius: BorderRadius.circular(40)
//           ),
//           height: myHeight*0.05,
//           width: myWidth*0.6,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
//             child: TextField(
//               style: TextStyle(
//                   fontSize: 15
//               ),
//               controller: _searchController,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 // border: OutlineInputBorder(
//                 //   borderRadius: BorderRadius.circular(20)
//                 // ),
//                 suffixIcon: Icon(
//                   Icons.search,
//                   color: Colors.black,
//                 ),
//                 hintText: '  Search...',
//               ),
//               onChanged: (value) {
//                 setState(() {});
//               },
//             ),
//           ),
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _buildQuery().snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           } else {
//             List<DocumentSnapshot> searchResults = snapshot.data!.docs;
//             return ListView.builder(
//               itemCount: searchResults.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot data = searchResults[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => SelectedBuyPage(item: data)));
//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                     width: myWidth * 0.4,
//                     child: Card(
//                       elevation: 8,
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5),
//                             child: Image(
//                                 image: NetworkImage(data['imageUrl']),
//                                 height: myHeight * 0.2,
//                                 width: myWidth * 0.7),
//                           ),
//                           Container(
//                             color: Colors.cyan[100],
//                             child: ListTile(
//                               title: Text(data['selltitle']),
//                               subtitle: Text(
//                                 "\$${data['sellprice']}",
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               trailing: user!.uid == data['createdby']
//                                   ? Text(
//                                 'Uploaded By: YOU',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold),
//                               )
//                                   : Text("Uploaded By: ${data['creatorname']}"),
//                             ),
//                           ),
//                         ],
//                       ),
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
//   Query _buildQuery() {
//     Query searchQuery = usersCollection;
//
//     if (_searchController.text.isNotEmpty) {
//       String searchValue = _searchController.text;
//       searchQuery =
//           searchQuery.where('selltitle', isGreaterThanOrEqualTo: searchValue);
//     }
//
//     return searchQuery;
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }