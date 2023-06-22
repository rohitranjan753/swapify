import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class ChatScreen extends StatelessWidget {
//   final String chatId;
//
//   ChatScreen({required this.chatId});
//
//   // Controller for the message input field
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   // Function to send a message
//   void sendMessage(String message) {
//     FirebaseFirestore.instance
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages')
//         .add({
//       'message': message,
//       'timestamp': FieldValue.serverTimestamp(),
//       'sender': _auth.currentUser!.uid, // Add sender information
//     });
//   }
//
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
//         title: Text('Chat Screen'),
//       ),
//       body: Column(
//         children: [
//           // Widget to display messages
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('chats')
//                   .doc(chatId)
//                   .collection('messages')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 }
//                 if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Text('No messages found');
//                 }
//                 // Render your chat screen UI with the loaded messages
//                 return ListView(
//                   reverse: true,
//                   children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                     String message = document['message'];
//                     String sender = document['sender'];
//
//                     // Determine if the message is from the current user
//                     bool isCurrentUser = sender == _auth.currentUser!.uid;
//
//                     // Set the alignment and background color based on the message sender
//                     CrossAxisAlignment alignment =
//                     isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
//                     Color backgroundColor =
//                     isCurrentUser ? Colors.blue : Colors.grey[300]!;
//
//                     BorderRadius borderradius = isCurrentUser ? BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                       bottomLeft: Radius.circular(20),
//                       bottomRight: Radius.circular(0),
//                     ):BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                       bottomLeft: Radius.circular(0),
//                       bottomRight: Radius.circular(20),
//                     );
//
//                     // Set the text color based on the message sender
//                     Color textColor = isCurrentUser ? Colors.white : Colors.black;
//
//                     return Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
//                       child: Column(
//                         crossAxisAlignment: alignment,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: backgroundColor,
//                               borderRadius: borderradius,
//                             ),
//                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 13),
//                             child: Text(
//                               message,
//                               style: TextStyle(color: textColor,fontSize: 17),
//                             ),
//                           ),
//                           SizedBox(height: 4.0),
//                           if (isCurrentUser)
//                             Text(
//                               'You', // Display 'You' for current user's messages
//                               style: TextStyle(fontSize: 12.0),
//                             ),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 );
//               },
//             ),
//           ),
//           // Input field and send button
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     style: TextStyle(fontSize: 20),
//                     maxLines: null,
//                     keyboardType: TextInputType.multiline,
//                     textCapitalization: TextCapitalization.sentences,
//                     autocorrect: true,
//                     enableSuggestions: true,
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Type your message...',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         )
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   color: Colors.cyan,
//                   onPressed: () {
//                     String message = _messageController.text.trim();
//                     if (message.isNotEmpty) {
//                       sendMessage(message);
//                       _messageController.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



class ChatScreen extends StatelessWidget {
  final String chatId;
  // final String currentUserId;
  // final String otherUserId;


  ChatScreen({required this.chatId});

  // Controller for the message input field
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Function to send a message
  void sendMessage(String message) {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
      'sender': _auth.currentUser!.uid, // Add sender information
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Do something when the menu icon is pressed
            Navigator.pop(context);
          },
        ),
        title: Text('Chat Screen'),
      ),
      body: Column(
        children: [
          // Widget to display messages
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('No messages found');
                }
                // Render your chat screen UI with the loaded messages
                return ListView(
                  reverse: true,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    String message = document['message'];
                    String sender = document['sender'];

                    // Determine if the message is from the current user
                    bool isCurrentUser = sender == _auth.currentUser!.uid;

                    // Set the alignment and background color based on the message sender
                    CrossAxisAlignment alignment =
                    isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
                    Color? backgroundColor =
                    isCurrentUser ? Colors.deepPurple[200] : Colors.grey[300]!;

                    BorderRadius borderradius = isCurrentUser ? BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(0),
                    ):BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(20),
                    );

                    // Set the text color based on the message sender
                    Color textColor = isCurrentUser ? Colors.white : Colors.black;

                    // Retrieve timestamp from document and format it
                    // Retrieve timestamp from document and format it
                    Timestamp? timestamp = document['timestamp'] as Timestamp?;
                    DateTime? dateTime = timestamp?.toDate();
                    // String formattedDateTime = DateFormat('MMM d, h:mm a').format(dateTime);
                    String formattedTime = dateTime != null ? DateFormat.MMMd().format(dateTime) : '';
                    // Format as 'h:mm a'// Format as 'h:mm a'

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      child: Column(
                        crossAxisAlignment: alignment,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: borderradius,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message,
                                  style: TextStyle(color: textColor, fontSize: 17),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  formattedTime, // Display formatted timestamp
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4.0),
                          if (isCurrentUser)
                            Text(
                              'You', // Display 'You' for current user's messages
                              style: TextStyle(fontSize: 12.0),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          // Input field and send button
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: true,
                    enableSuggestions: true,
                    controller: _messageController,
                    decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        )
                    ),
                  ),
                ),
                IconButton(
                  icon: Image(
                    image: AssetImage('assets/send_chat1.png'),
                  ),

                  onPressed: () {
                    String message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      sendMessage(message);
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
