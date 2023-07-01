import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vbuddyproject/Constants/image_string.dart';
import 'package:vbuddyproject/authMainScreen/auth_screen.dart';
import 'package:vbuddyproject/nav_bar.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Define the animation duration
    const splashDuration = Duration(seconds: 4);

    // Create the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: splashDuration,
    );

    // Create the fade-in animation
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    // Start the animation
    _animationController.forward();

    // Redirect to the home page after the animation finishes
    Timer(splashDuration, () {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NavBar()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
      }

    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(swapifyLogo,
          width: size.width*0.6,
          height: size.height*0.6,), // Replace with your image path
        ),
      ),
    );
  }
}
