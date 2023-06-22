import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vbuddyproject/Constants/sizes.dart';
import 'package:vbuddyproject/welcome_screen.dart';
import 'package:vbuddyproject/widget/animation_widget.dart';
import 'package:vbuddyproject/widget/fade_in_animation_model.dart';
import 'package:vbuddyproject/widget/fade_in_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  bool animate = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();

    return Scaffold(
      body: Stack(
        children: [
          TFadeInAnimation(
            animate: TAnimatedPosition(
              topAfter: 0,
              topBefore: -30,
              leftBefore: -30,
              leftAfter: 0,
            ),
            durationInMs: 1600,
            child: Container(
              height: 80,
              width: 80,
              child: const Image(
                image: AssetImage("assets/splash/trade.png"),
              ),
            ),
          ),
          TFadeInAnimation(
            animate: TAnimatedPosition(
                topBefore: 80,
                topAfter: 80,
                leftAfter: tDefaultSize,
                leftBefore: -80),
            durationInMs: 2000,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to Swapify",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  "where second-hand becomes first choice",
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          TFadeInAnimation(
            animate: TAnimatedPosition(bottomBefore: 0, bottomAfter: 100),
            durationInMs: 2400,
            child: Image(
              image: AssetImage("assets/splash/splash.png"),
              height: size.height*0.3,
            ),
          ),
          TFadeInAnimation(
            animate: TAnimatedPosition(
                bottomBefore: 0,
                bottomAfter: 60,
                rightBefore: -30,
                rightAfter: 30),
            durationInMs: 2400,
            child: Container(
              height: 80,
              width: 80,
              child: const Image(
                image: AssetImage("assets/splash/cart.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

