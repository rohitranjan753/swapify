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

class BuyPage extends StatefulWidget {
  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
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
              hintText: 'Search...',
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
                 child: Card(
                   child: Column(
                     children: [
                       Image(
                           image: NetworkImage(data['imageUrl']),
                           height: myHeight * 0.2,
                           width: myWidth * 0.7),
                       ListTile(
                         title: Text(data['selltitle']),
                         subtitle: Text(data['sellprice']),
                         trailing: user!.uid == data['createdby'] ? Text('Uploaded By: YOU',style: TextStyle(fontWeight: FontWeight.bold),) : Text("Uploaded By: ${data['creatorname']}"),
                       ),
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
