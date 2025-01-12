import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';

class CustomEditableText extends StatelessWidget {
  final TextEditingController controller;
  void Function()? onEditingComplete;
  CustomEditableText(
      {super.key, this.onEditingComplete, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4, right: 8, left: 8),
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(Dimensions.primaryRadius),
        ),
      ),
      width: 50,
      child: EditableText(
          controller: controller,
          focusNode: FocusNode(),
          maxLines: 1,
          style: const TextStyle(color: AppColors.black),
          cursorColor: AppColors.primaryColor,
          selectionColor: AppColors.primaryColorLow,
          onEditingComplete: onEditingComplete,
          backgroundCursorColor: AppColors.primaryColor),
    );
  }
}
