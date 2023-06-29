// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:vbuddyproject/widget/animation_widget.dart';
// // import 'package:vbuddyproject/widget/fade_in_animation_model.dart';
// // import 'package:vbuddyproject/widget/fade_in_controller.dart';
// //
// // class SplashScreen extends StatelessWidget {
// //   SplashScreen({Key? key}) : super(key: key);
// //
// //   bool animate = false;
// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;
// //     final controller = Get.put(FadeInAnimationController());
// //     controller.startSplashAnimation();
// //
// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           Center(
// //             child: TFadeInAnimation(
// //               animate: TAnimatedPosition(
// //
// //               ),
// //               durationInMs: 1000,
// //               child: Container(
// //                 height: size.height*0.7,
// //                 width: size.width*0.7,
// //                 child: const Image(
// //                   image: AssetImage("assets/swapify_full_logo.png"),
// //                 ),
// //               ),
// //             ),
// //           ),
// //
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
//
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          child: Image.asset('assets/swapify_full_logo.png',
          width: size.width*0.6,
          height: size.height*0.6,), // Replace with your image path
        ),
      ),
    );
  }
}




// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:vbuddyproject/authMainScreen/auth_screen.dart';
// import 'package:vbuddyproject/nav_bar.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeIn,
//       ),
//     );
//
//     _animationController.forward().whenComplete(() {
//       // Animation completed, navigate to the appropriate screen
//       redirectToScreen();
//     });
//   }
//
//   void redirectToScreen() {
//     // Check user's sign-in status and redirect accordingly
//     // Replace this logic with your actual sign-in check
//     bool isSignedIn = false;
//     if (FirebaseAuth.instance.currentUser != null) {
//       isSignedIn = true;
//       }
//     // Replace with actual sign-in check
//     if (isSignedIn) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => NavBar()),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => AuthScreen()),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Center(
//           child: Image.asset('assets/swapify_full_logo.png'), // Replace with your splash image asset
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
// }
