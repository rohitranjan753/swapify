import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<DocumentSnapshot> searchResults = snapshot.data!.docs;
            return ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot data = searchResults[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectedBuyPage(item: data)));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    width: myWidth * 0.4,
                    child: Card(
                      elevation: 8,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Image(
                                image: NetworkImage(data['imageUrl']),
                                height: myHeight * 0.2,
                                width: myWidth * 0.7),
                          ),
                          Container(
                            color: Colors.cyan[100],
                            child: ListTile(
                              title: Text(data['renttitle']),
                              subtitle: Text(
                                "\$${data['rentprice']}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: user!.uid == data['createdby']
                                  ? Text(
                                'Uploaded By: YOU',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                                  : Text("Uploaded By: ${data['creatorname']}"),
                            ),
                          ),
                        ],
                      ),
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
