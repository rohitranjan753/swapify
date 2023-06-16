import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vbuddyproject/Constants/sizes.dart';
import 'package:vbuddyproject/widget/animation_widget.dart';
import 'package:vbuddyproject/widget/fade_in_animation_model.dart';
import 'package:vbuddyproject/widget/fade_in_controller.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();

    return Scaffold(
      body: Stack(
        children: [
          TFadeInAnimation(
            animate: TAnimatedPosition(topAfter: 0,
            topBefore: -30,
            leftAfter: 0,
            leftBefore: -30
            ),
            durationInMs: 1600,
            child: const Image(
              image: AssetImage("assets/splash/trade.png"),
            ),
          ),

          TFadeInAnimation(
            animate: TAnimatedPosition(topAfter: 80,
            topBefore: 80,
            leftAfter: tDefaultSize,
            leftBefore: -80
            ),
            durationInMs: 2000,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to vBuddy",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  "Sell your belongings",
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
        
          ),

          TFadeInAnimation(
            animate: TAnimatedPosition(bottomAfter: 100,
              bottomBefore: 0,
            ),
            durationInMs: 1600,
            child: const Image(
              image: AssetImage("assets/splash/splash.png"),
            ),
          ),


          TFadeInAnimation(
            animate: TAnimatedPosition(
              bottomAfter: 60,
              bottomBefore: 0,
              rightBefore: tDefaultSize,
              rightAfter: tDefaultSize
            ),
            durationInMs: 1600,
            child: const Image(
              image: AssetImage("assets/splash/cart.png"),
            ),
          ),
        


        ],
      ),
    );
  }
}
