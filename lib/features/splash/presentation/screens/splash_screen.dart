import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/core/widgets/background_image.dart';
import 'package:ngu_app/features/splash/cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..startTime(),
      lazy: false,
      child: Scaffold(
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
                      AppColors.primaryColor,
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
      ),
    );
  }
}
