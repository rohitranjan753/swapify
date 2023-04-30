import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
class ChatMainScreen extends StatefulWidget {
  const ChatMainScreen({Key? key}) : super(key: key);

  @override
  State<ChatMainScreen> createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {

  final DocumentReference parentDocRef =
  FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: parentDocRef.collection('ChatList').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final dataList = snapshot.data!.docs;
          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final doc = dataList[index];
              return Card(
                child: ListTile(
                  title: Text(doc['title']),
                  subtitle: Text(doc['description']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
