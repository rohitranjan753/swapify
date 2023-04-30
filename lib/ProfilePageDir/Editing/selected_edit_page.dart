import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:vbuddyproject/ProfilePageDir/Editing/edit_listing.dart';


class SelectedEditPage extends StatefulWidget {
  final DocumentSnapshot item;

  const SelectedEditPage({required this.item});

  @override
  State<SelectedEditPage> createState() => _SelectedEditPageState();
}

class _SelectedEditPageState extends State<SelectedEditPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = widget.item['createdAt'];
    DateTime date = timestamp.toDate();

// Format the DateTime object as a string using the DateFormat class from the intl package
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);

    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[300],
        title: Text(widget.item['creatorname']),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(1000.0, 80.0, 0.0, 0.0),
                items: [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        Text('Edit'),
                      ],
                    ),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        Text('Delete'),
                      ],
                    ),
                    value: 2,
                  ),
                ],
              ).then((value) {
                switch (value) {
                  case 1:
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
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: Color.fromRGBO(255, 248, 238, 10),
          height: myHeight,
          width: myWidth,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: myHeight * 0.4,
                  // width: myWidth * 0.3,
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
                        image: NetworkImage(widget.item['imageUrl']),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      bottom: 10,
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
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Category",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
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
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Description",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
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
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Uploaded By",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            widget.item['creatorname'],
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
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Uploaded On",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
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
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Price",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: widget.item['category'].toString() == "sell" ?Text(
                            "₹${widget.item['price']}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ) : Text(
                            "₹${widget.item['price']} / 12Hrs",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditListing(item: widget.item,)));
                      },
                      minWidth: myWidth*0.4,
                      height: 50,
                      color: Colors.cyan,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "EDIT",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: MaterialButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Delete Listing'),
                            content: Text('Are you sure you want to delete?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'No');
                                },
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  deleteDocument(widget.item.id);
                                  Navigator.pop(context, 'Yes');
                                  Navigator.pop(context);
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          ),
                        );
                      },
                      minWidth: myWidth*0.4,
                      height: 50,
                      color: Colors.red[400],
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "DELETE",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void deleteDocument(documentId) {
    FirebaseFirestore.instance
        .collection('all_section')
        .doc(documentId)
        .delete()
        .then((value) => print("Document deleted"))
        .catchError((error) => print("Failed to delete document: $error"));
  }
}
