import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vbuddyproject/Chat/yourchatScreen.dart';

class ChatPage extends StatelessWidget {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String?> getUsername(String userId) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();

    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      String? username = userData['username'];
      print("User name $username");
      return username;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('chats').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No chats found');
          }
          // Render the chat list UI with all the chats
          return ListView(
            padding: EdgeInsets.all(16.0),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              String chatId = document.id;
              List<dynamic> users = document['users'];

              // Determine the other user's ID and Name
              String otherUsername = '';
              String otherUserId =
                  users.firstWhere((userId) => userId != _auth.currentUser!.uid);

              String userId = otherUserId; // Replace with the desired user ID

              print("Other user Id $userId");

              void fetchUsername() async {
                String? username = await getUsername(userId);
                if (username != null) {
                  print('Username: $username');
                } else {
                  print('User not found or username is null');
                }
              }

              return Card(
                child: ListTile(
                  title: Text('Chat with $otherUsername'),
                  onTap: () {
                    navigateToChatScreen(context, chatId);
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }


  // Function to navigate to the chat screen with the provided chat ID
  void navigateToChatScreen(BuildContext context, String chatId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => YourChatScreen(chatId: chatId)),
    );
  }
}
