import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:ngu_app/core/config/app_ui.dart';
import 'package:ngu_app/core/config/constant.dart';
import 'package:ngu_app/core/presentation/widgets/background_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    startTime();
    super.initState();
  }

  void startTime() async {
    var duration = const Duration(seconds: 1);
    Timer(duration, go);
  }

  void go() async {
    await Future.delayed(const Duration(seconds: 3));
    // Get.to(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animations/splash_animation.json',
                height: MediaQuery.of(context).size.width * 0.2),
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  '${'accounting_system'.tr} ${'ngu'.tr} ',
                  colors: [
                    AppUI.secondaryColor,
                    AppUI.transparent,
                  ],
                  textStyle:
                      const TextStyle(fontSize: Dimensions.largeTextSize),
                )
              ],
              isRepeatingAnimation: true,
              repeatForever: true,
            ),
          ],
        ),
      ),
    );
  }
}
