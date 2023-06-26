import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vbuddyproject/SearchPageDir/selected_search_page.dart';
import 'package:vbuddyproject/widget/back_btn_design.dart';

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
        leading: backiconButtonDesign(),
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
        ),
        title: searchContainerDesign(myHeight, myWidth),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('all_section')
            .where('category', isEqualTo: 'sell')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final documents = snapshot.data!.docs.where((doc) => doc['title']
              .toString()
              .toLowerCase()
              .contains(searchText.toLowerCase()));
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SelectedSearchPage(item: data)));
                },
                child: Card(
                  elevation: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.network(
                            data['imageUrl'],
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 1),
                        child: Text(
                          data['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                        child: Text(
                          "₹${data["price"]}",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
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

  Container searchContainerDesign(double myHeight, double myWidth) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(15)),
        height: myHeight * 0.05,
        width: myWidth * 0.7,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            style: TextStyle(fontSize: 18),
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: Icon(
                Icons.search,

              ),
              hintText: 'Search...',
            ),
          ),
        ),
      );
  }

  @override
  void dispose() {
    super.dispose();
  }
}


