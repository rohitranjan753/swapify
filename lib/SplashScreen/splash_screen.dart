import 'package:flutter/material.dart';
import 'package:vbuddyproject/Constants/sizes.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image(
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
          const Positioned(
            bottom: 100,
            child: Image(
              image: AssetImage("assets/splash/splash.png"),
            ),
          ),

          const Positioned(
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
