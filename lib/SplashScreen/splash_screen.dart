import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vbuddyproject/Constants/sizes.dart';
import 'package:vbuddyproject/widget/animation_widget.dart';
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
            durationInMs: 1600,
            child: const Image(
              image: AssetImage("assets/splash/trade.png"),
            ),
          ),
          Positioned(
            top: 80,
            left: tDefaultSize,
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
          Positioned(
            bottom: 100,
            child: Image(
              image: AssetImage("assets/splash/splash.png"),
            ),
          ),
          Positioned(
            bottom: 40,
            right: tDefaultSize,
            child: Image(
              image: AssetImage("assets/splash/cart.png"),
            ),
          ),
        ],
      ),
    );
  }
}
