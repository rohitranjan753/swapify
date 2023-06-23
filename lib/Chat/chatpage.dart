import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vbuddyproject/Chat/chat_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
//
// class ChatPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             // Do something when the menu icon is pressed
//             Navigator.pop(context);
//           },
//         ),
//         title: Text('Chat'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('chats').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Text('No chats found');
//           }
//           // Render the chat list UI with all the chats
//           return ListView(
//             padding: EdgeInsets.all(16.0),
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               String chatId = document.id;
//               List<dynamic> users = document['users'];
//
//               // Determine the other user's ID
//               String otherUserId = users.firstWhere((userId) => userId != getCurrentUserId());
//
//               return Card(
//                 child: ListTile(
//                   title: FutureBuilder<String?>(
//                     future: getUsername(otherUserId),
//                     builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return LinearProgressIndicator(
//                         );
//                       }
//                       if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
//                         return Text('User not found');
//                       }
//                       // Display the chat item with the other user's username
//                       return Text(' ${snapshot.data}',style: TextStyle(
//                         fontSize: 25
//                       ),);
//                     },
//                   ),
//                   onTap: () {
//                     navigateToChatScreen(context, chatId);
//                   },
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
//
//   // Function to get the current user ID (replace with your own logic)
//   String getCurrentUserId() {
//     return _auth.currentUser!.uid;
//   }
//
//   // Function to navigate to the chat screen with the provided chat ID
//   void navigateToChatScreen(BuildContext context, String chatId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ChatScreen(chatId: chatId)),
//     );
//   }
//
//   // Function to fetch the username for a given user ID from Firestore
//   Future<String?> getUsername(String userId) async {
//     DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
//
//     if (snapshot.exists) {
//       Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
//       String? username = userData['username'];
//       return username;
//     }
//
//     return null;
//   }
// }
//

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Do something when the menu icon is pressed
            Navigator.pop(context);
          },
        ),
        title: Text('Chat'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('users', arrayContains: getCurrentUserId())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Align(
              alignment: Alignment.center,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 20,
                child: Container(
                  height: size.height * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                          "assets/chat_error.png",
                        ),
                        width: size.height * 0.3,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        'No chats found',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          // Render the chat list UI with all the chats
          return ListView(
            padding: EdgeInsets.all(16.0),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              String chatId = document.id;
              List<dynamic> users = document['users'];

              // Determine the other user's ID
              String otherUserId =
                  users.firstWhere((userId) => userId != getCurrentUserId());

              return FutureBuilder<List<String>?>(
                future: getUserData(otherUserId),
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LinearProgressIndicator();
                  }
                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data == null) {
                    return Text('User not found');
                  }

                  // Retrieve the user image URL and username from the snapshot data
                  List<String> userData = snapshot.data!;
                  String imageUrl = userData[0];
                  String username = userData[1];

                  // Display the chat item with the user image and username
                  // return Card(
                  //   elevation: 5,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: ListTile(
                  //       leading: CircleAvatar(
                  //         backgroundImage: NetworkImage(imageUrl),
                  //       ),
                  //       title: Text(
                  //         username,
                  //         style: TextStyle(fontSize: 25),
                  //       ),
                  //       onTap: () {
                  //         navigateToChatScreen(context, chatId);
                  //       },
                  //     ),
                  //   ),
                  // );
                  return GestureDetector(
                    onTap: () {
                      navigateToChatScreen(context, chatId);
                    },
                    child: Card(
                      elevation: 5,
                      child: Container(
                        height: size.height * 0.09,
                        child: Row(

                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(imageUrl),
                              ),
                            ),
                            Text(
                              username,
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }

  // Function to get the current user ID (replace with your own logic)
  String getCurrentUserId() {
    return _auth.currentUser!.uid;
  }

  // Function to navigate to the chat screen with the provided chat ID
  void navigateToChatScreen(BuildContext context, String chatId) {
    // final String curUser = getCurrentUserId();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatScreen(chatId: chatId)),
    );
  }

  // Function to fetch the user image URL and username for a given user ID from Firestore
  Future<List<String>?> getUserData(String userId) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();

    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      String username = userData['username'];
      String imageUrl = userData['userimage'];
      return [imageUrl, username];
    }

    return null;
  }
}
