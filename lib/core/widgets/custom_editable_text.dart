import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';

class CustomEditableText extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final String hint;
  final String helper;
  void Function()? onEditingComplete;
  void Function(String)? onChanged;
  final bool enable;
  CustomEditableText(
      {super.key,
      this.onEditingComplete,
      this.onChanged,
      required this.controller,
      this.width = 0.05,
      this.hint = '',
      this.helper = '',
      this.enable = false});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hint,
            style: const TextStyle(
                color: Colors.grey, fontSize: Dimensions.numberTextSize),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: enable
                  ? AppColors.primaryColorLow.withAlpha(51)
                  : AppColors.secondaryColor,
              border: Border.all(
                  color: enable ? AppColors.black : AppColors.primaryColorLow,
                  width: 0.6),
              borderRadius: const BorderRadius.all(
                Radius.circular(Dimensions.primaryRadius),
              ),
            ),
            width: MediaQuery.sizeOf(context).width * width,
            child: EditableText(
              controller: controller,
              focusNode: FocusNode(),
              autofocus: true,
              maxLines: 1,
              readOnly: !enable,
              style: const TextStyle(color: AppColors.black),
              cursorColor: AppColors.primaryColor,
              selectionColor: AppColors.primaryColorLow,
              onEditingComplete: onEditingComplete,
              onChanged: onChanged,
              backgroundCursorColor: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            helper,
            style: const TextStyle(
                color: Colors.grey, fontSize: Dimensions.numberTextSize),
          ),
        ],
      ),
    );
  }
}
