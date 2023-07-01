import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vbuddyproject/authMainScreen/auth_form.dart';
import 'package:vbuddyproject/nav_bar.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;


  var _isLoading = false;
  final String defaultImageLogo = 'https://firebasestorage.googleapis.com/v0/b/vbuddyproject-99a8a.appspot.com/o/images%2Fuser_logo.png?alt=media&token=debafca9-68fc-499d-b2a1-5e12f2e2f665';

  void _submitAuthForm(String email, String password, String username, bool isLogin, BuildContext ctx) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;

      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password,);

      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password,);
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
          'userimage': defaultImageLogo
          // 'image_url': url,
        });
      }
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => NavBar()),
            (Route<dynamic> route) => false,
      );
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>NavBar()));
      // Get.offAll(() => NavBar());
    } on FirebaseAuthException catch (e) {
      String? message = "An error occured, Check credential";
      if (e.message != null) {
        message = e.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message!),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}


