import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vbuddyproject/authMainScreen/auth_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Do something when the menu icon is pressed
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("Settings"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 100,),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(onPressed: (){
                Navigator.pop(context);
                GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut();
                Get.offAll(() => AuthScreen());
              },
                elevation: 20,
                minWidth: myWidth*0.6,
                height: myHeight*0.06,
                color: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  'LOGOUT',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 18,color: Colors.white),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
