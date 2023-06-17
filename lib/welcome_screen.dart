import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vbuddyproject/Constants/constant.dart';
import 'package:vbuddyproject/LoginSignUpT/tlogin_screen.dart';
import 'package:vbuddyproject/widget/animation_widget.dart';
import 'package:vbuddyproject/widget/fade_in_animation_model.dart';
import 'package:vbuddyproject/widget/fade_in_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();
    var myHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          TFadeInAnimation(
            durationInMs: 1200,
            animate: TAnimatedPosition(
              topBefore: 0,
              bottomBefore: -100,
              leftBefore: 0,
              rightBefore: 0,
              topAfter: 0,
              bottomAfter: 0,
              leftAfter: 0,
              rightAfter: 0,
            ),
            child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                    image: AssetImage("assets/images/upload.png"),
                    height: myHeight * 0.6,
                  ),
                  Column(
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
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(),
                            primary: AppColors.tSecondaryColour,
                            side: BorderSide(color: AppColors.tSecondaryColour),
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
        onPressed: () => Get.to(() => const TLoginScreen()),
                          child: Text("LOGIN"),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(),
                            onPrimary: Colors.white,
                            primary: AppColors.tSecondaryColour,
                            side: BorderSide(color: AppColors.tSecondaryColour),
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: Text("SIGNUP"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
