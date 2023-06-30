import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vbuddyproject/Constants/image_string.dart';
import 'package:vbuddyproject/SearchPageDir/selected_search_page.dart';
import 'package:vbuddyproject/widget/back_btn_design.dart';

class BrowseCategoryScreen extends StatefulWidget {
  final int index;
  final List categoryName;

  BrowseCategoryScreen({required this.index, required this.categoryName});

  @override
  State<BrowseCategoryScreen> createState() => _BrowseCategoryScreenState();
}

class _BrowseCategoryScreenState extends State<BrowseCategoryScreen> {
  TextEditingController _searchController = TextEditingController();
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance
        .collection('all_section')
        .where('majorcategory', isEqualTo: widget.categoryName[widget.index].toString())
        .snapshots();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        toolbarHeight: 60,
        leading: const backiconButtonDesign(),
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          height: myHeight * 0.05,
          width: myWidth * 0.7,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _searchController,
              style: TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {});
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = snapshot.data!.docs;
          final filteredDocuments = documents.where((doc) {
            final title = doc['title'].toString().toLowerCase();
            final searchText = _searchController.text.toLowerCase();
            return title.contains(searchText);
          }).toList();

          if (filteredDocuments.isEmpty) {
            return Align(
              alignment: Alignment.center,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 20,
                child: Container(
                  height: myHeight * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(itemNotFoundImage),
                          width: myWidth * 0.5,
                        ),
                        SizedBox(
                          height: myHeight * 0.02,
                        ),
                        Text(
                          'No item found!',
                          style: TextStyle(fontSize: 30, color: Colors.deepPurple),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.75,
            ),
            itemCount: filteredDocuments.length,
            itemBuilder: (context, index) {
              final data = filteredDocuments[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectedSearchPage(item: data),
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
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
                      data["category"].toString() == "sell"
                          ? Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "₹${data["price"]}",
                          style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                        ),
                      )
                          : Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "₹ ${data["price"]} /${data["perhourvalue"]}hrs",
                          style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
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
}

