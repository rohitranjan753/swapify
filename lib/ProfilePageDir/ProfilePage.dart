import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60,),
          ElevatedButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          }, child: Text('LOGOUT'),),
          Center(
            child:
            Text('Profile PAGE'),
          ),
        ],
      ),
    );
  }
}
