
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashScreenController>(
        init: SplashScreenController(),
        builder: (controller) {
          return SizedBox(
            width: Get.width,
            height: Get.height,
            child: Center(
              child: Image.asset(
                'assets/images/logo_bion.png',
                width: 250,
                height: 250,
              ),
            ),
          );
        },
      ),
    );
  }
}
