import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vbuddyproject/Chat/yourchatScreen.dart';

class ChatPage extends StatelessWidget {

  Future<String> getOtherUserName(String otherUserId) async {
    String currentUserId = otherUserId; // Replace with your logic to get the current user ID

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUserId)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      String userName = userData['username'];
      return userName;
    }

    return '';
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

              // Determine the other user's ID
              String otherUsername='';
              String otherUserId = users.firstWhere((userId) => userId != getCurrentUserId());

              void fetchCurrentUserName() async {
                otherUsername = await getOtherUserName(otherUserId);
                print('Other user name: $otherUsername');
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

  // Function to get the current user ID (replace with your own logic)
  String getCurrentUserId() {
    return 'current_user_id';
  }

  // Function to navigate to the chat screen with the provided chat ID
  void navigateToChatScreen(BuildContext context, String chatId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => YourChatScreen(chatId: chatId)),
    );
  }
}
