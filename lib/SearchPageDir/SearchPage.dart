import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vbuddyproject/HomePageDir/category_screen.dart';
import 'package:vbuddyproject/SearchPageDir/selected_search_page.dart';
import 'package:vbuddyproject/widget/back_btn_design.dart';

final CollectionReference allsection =
    FirebaseFirestore.instance.collection('all_section');

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}



class _SearchPageState extends State<SearchPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  String searchText = '';
  int initialItemCount = 40;
  int loadMoreItemCount = 40;
  bool hasMoreData = true;

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu_sharp,
              color: Colors.black54,
            ),
            tooltip: 'Menu',
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(1000.0, 80.0, 0.0, 0.0),
                items: [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(
                          Icons.category_rounded,
                          color: Colors.deepPurple,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text('All Category'),
                      ],
                    ),
                    value: 1,
                  ),
                ],
              ).then((value) {
                switch (value) {
                  case 1:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryScreen()));
                    break;
                  case 2:
                    Navigator.pushNamed(context, '/screen2');
                    break;
                  default:
                    break;
                }
              });
            },
          ),
        ],
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
        ),
        title: Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(15)),
            height: myHeight * 0.05,
            width: myWidth * 0.7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('all_section').orderBy('createdAt',descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final documents = snapshot.data!.docs
              .where((doc) => doc['title']
                  .toString()
                  .toLowerCase()
                  .contains(searchText.toLowerCase()))
              .take(initialItemCount);
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
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
                                SelectedSearchPage(item: data),
                          ),
                        );
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
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
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
                            data["category"].toString() == "sell"
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 2),
                                    child: Text(
                                      "₹${data["price"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 2),
                                    child: Text(
                                      "₹ ${data["price"]} /${data['perhourvalue']} hrs",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (hasMoreData)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      initialItemCount += loadMoreItemCount;
                    });
                  },
                  child: Text('Load More',style: TextStyle(fontSize: 14),),
                ),
            ],
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