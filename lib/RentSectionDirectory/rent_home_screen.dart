import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vbuddyproject/Model/rent_item_widget.dart';
import 'package:vbuddyproject/RentSectionDirectory/selected_rent_page.dart';

import '../Model/rent_item_model.dart';

final CollectionReference usersCollection =
FirebaseFirestore.instance.collection('rent_major_section');

class RentHomeScreen extends StatefulWidget {
  const RentHomeScreen({Key? key}) : super(key: key);

  @override
  State<RentHomeScreen> createState() => _RentHomeScreenState();
}

class _RentHomeScreenState extends State<RentHomeScreen> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[400],
        title: Container(
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
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(20)
                // ),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _buildQuery().snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data!.docs[index];
              RentItemModel item = RentItemModel(
                id: data.id,
                title: data['renttitle'],
                imageUrl: data['imageUrl'],
                creatorName:data['creatorname'],
                createdby:data['createdby'],
                price: data['rentprice'],
              );
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectedRentPage(item: data)));
                  },
                  child: RentItemWidget(item: item));
            },
          );
        },
      ),
    );
  }

  Query _buildQuery() {
    Query searchQuery = usersCollection;

    if (_searchController.text.isNotEmpty) {
      String searchValue = _searchController.text;
      searchQuery =
          searchQuery.where('renttitle', isGreaterThanOrEqualTo: searchValue);
    }

    return searchQuery;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
