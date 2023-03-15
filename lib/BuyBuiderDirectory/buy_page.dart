import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuyPage extends StatefulWidget {
  const BuyPage({Key? key}) : super(key: key);

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  // This function retrieves data from the Firebase Firestore
  Stream<QuerySnapshot> getNestedData() {
    return FirebaseFirestore.instance
        .collection('sell_major_section')
        // .doc(FirebaseAuth.instance.currentUser!.uid)
        // .collection('sellsection')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseStorage storage = FirebaseStorage.instance;
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Section'),
      ),
      body: StreamBuilder<QuerySnapshot>(
              stream: getNestedData(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return Text('Loading...');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];

                      return Card(
                        child: Column(
                          children: [
                            Image(
                                image: NetworkImage(document['imageUrl']),
                                height: myHeight * 0.2,
                                width: myWidth * 0.7),
                            ListTile(
                              title: Text(document['selltitle']),
                              subtitle: Text(document['sellprice']),
                              trailing: user!.uid == document['createdby'] ? Text('YOU') : Text(document['creatorname']),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
    );
  }

}
