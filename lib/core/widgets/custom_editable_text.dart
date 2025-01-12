import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';

class CustomEditableText extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  void Function()? onEditingComplete;
  final bool enable;
  CustomEditableText(
      {super.key,
      this.onEditingComplete,
      required this.controller,
      this.width = 0.05,
      this.enable = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4, right: 8, left: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: enable ? AppColors.white : AppColors.secondaryColor,
        border: Border.all(
            color:
                enable ? AppColors.secondaryColor : AppColors.primaryColorLow),
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.primaryRadius),
        ),
      ),
      width: MediaQuery.sizeOf(context).width * width,
      child: EditableText(
          controller: controller,
          focusNode: FocusNode(),
          maxLines: 1,
          readOnly: !enable,
          style: const TextStyle(color: AppColors.black),
          cursorColor: AppColors.primaryColor,
          selectionColor: AppColors.primaryColorLow,
          onEditingComplete: onEditingComplete,
          backgroundCursorColor: AppColors.primaryColor),
    );
  }
}
