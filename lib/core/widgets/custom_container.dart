import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimensions.primaryPadding),
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      decoration: const BoxDecoration(
        color: AppColors.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColorLow,
            offset: Offset(1, 1),
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(Dimensions.primaryPadding),
        ),
      ),
      child: child,
    );
  }
}
