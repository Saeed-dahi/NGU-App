import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';

class BackgroundImage extends StatelessWidget {
  final Widget body;
  const BackgroundImage({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage("assets/images/app_background.jpeg"),
          //     fit: BoxFit.fill,
          //     opacity: 0.05,
          //     repeat: ImageRepeat.repeatX),
          color: AppColors.primaryColorLow),
      child: body,
    );
  }
}
