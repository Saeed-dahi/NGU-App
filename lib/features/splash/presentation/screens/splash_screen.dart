import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/config/constant.dart';
import 'package:ngu_app/core/widgets/background_image.dart';
import 'package:ngu_app/features/home/presentation/pages/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
    Get.off(const HomeScreen());
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
                  '${'accounting_system'.tr}  ',
                  colors: [
                    AppColors.secondaryColor,
                    AppColors.transparent,
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
