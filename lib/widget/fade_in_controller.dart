import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vbuddyproject/authMainScreen/auth_screen.dart';
import 'package:vbuddyproject/nav_bar.dart';

class FadeInAnimationController extends GetxController{
  static FadeInAnimationController get find => Get.find();

  RxBool animate = false.obs;


  Future startAnimation() async{
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value= true;
  }

  Future startSplashAnimation() async{
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 1500));
    animate.value = false;
    await Future.delayed(const Duration(milliseconds: 2000));
    // checkUserLoggedIn();
    if (FirebaseAuth.instance.currentUser != null) {
      Get.offAll(() => NavBar());
    } else {
      Get.offAll(() => AuthScreen());
    }
  }
  //
  // void checkUserLoggedIn() {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user = auth.currentUser;
  //
  //   if (user != null) {
  //     Get.offAll(() => NavBar());
  //   } else {
  //     Get.offAll(() => AuthScreen());
  //   }
  // }

}