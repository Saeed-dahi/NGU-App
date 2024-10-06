import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/app_config/constant.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color color;
  final VoidCallback? onPressed;
  final String text;
  bool skipTraversal;
  CustomElevatedButton(
      {super.key,
      required this.color,
      required this.text,
      this.onPressed,
      this.skipTraversal = true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Dimensions.primaryRadius,
          ),
        ),
      ),
      focusNode: FocusNode(skipTraversal: skipTraversal),
      child: Text(
        text.tr,
        style: const TextStyle(
          color: AppColors.lightBgGrayColor,
        ),
      ),
    );
  }
}
