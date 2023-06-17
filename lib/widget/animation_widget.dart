import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vbuddyproject/widget/fade_in_animation_model.dart';
import 'package:vbuddyproject/widget/fade_in_controller.dart';

class TFadeInAnimation extends StatelessWidget {
  TFadeInAnimation({Key? key,
    required this.durationInMs,
    required this.child,
    this.animate,
  }) : super(key: key);


  final fadeController = Get.put(FadeInAnimationController());
  final int durationInMs;

  final TAnimatedPosition? animate;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=>AnimatedPositioned(
          duration: Duration(milliseconds: durationInMs),
          top: fadeController.animate.value ? animate!.topAfter : animate!.topBefore,
          left: fadeController.animate.value ? animate!.leftAfter : animate!.leftBefore,
          bottom: fadeController.animate.value ? animate!.bottomAfter : animate!.bottomAfter,
          right: fadeController.animate.value ? animate!.rightAfter : animate!.rightBefore,
          child: AnimatedOpacity(
          duration: Duration(milliseconds: durationInMs),
          opacity: fadeController.animate.value? 1: 0,
          child: child,
        ),

        ),
    );
  }


}
