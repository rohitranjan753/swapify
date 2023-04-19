import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vbuddyproject/SearchPageDir/selected_search_page.dart';

import '../BuyBuiderDirectory/selected_buy_page.dart';
import '../Model/item_model.dart';
import '../Model/item_widget.dart';

final CollectionReference sellsection =
FirebaseFirestore.instance.collection('all_section');


class SearchPage extends StatefulWidget {

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[400],
        title: Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(40)
            ),
            height: myHeight*0.05,
            width: myWidth*0.6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
              child: TextField(
                style: TextStyle(
                    fontSize: 15
                ),
                controller: _searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: '  Search...',
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      ),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance.collection('all_section').snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (snapshot.hasError) {
      //       return Text('Something went wrong');
      //     }
      //
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Text('Loading');
      //     }
      //
      //     return GridView.builder(
      //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2,
      //         crossAxisSpacing: 10.0,
      //         mainAxisSpacing: 10.0,
      //       ),
      //       itemCount: snapshot.data!.docs.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         DocumentSnapshot document = snapshot.data!.docs[index];
      //         return Container(
      //           child: Column(
      //             children: [
      //               Container(
      //                   color: Colors.tealAccent,
      //                   child: Image(image: NetworkImage(document['imageUrl']),height: 100,width: 100,)),
      //               Text(document['title']),
      //               Text(document['description']),
      //               Text(document['majorcategory']),
      //             ],
      //           ),
      //
      //         );
      //       },
      //     );
      //   },
      // )
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('all_section').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data!.docs[index];
              Item item = Item(
                id: data.id,
                title: data['title'],
                imageUrl: data['imageUrl'],
              );
              return ItemWidget(item: item);
            },
          );
        },
      ),

    );
  }

  Query _buildQuery() {
    Query searchQuery = sellsection;

    if (_searchController.text.isNotEmpty) {
      String searchValue = _searchController.text;
      searchQuery =
          searchQuery.where('selltitle', isGreaterThanOrEqualTo: searchValue);
    }

    return searchQuery;
  }


}
