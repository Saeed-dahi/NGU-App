// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/config/constant.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hint;
  final String prefix;
  final String suffix;
  final String helper;
  final String? error;
  final bool enabled;
  final bool required;
  final bool readOnly;
  VoidCallback? onTap;
  final TextInputType inputType;
  TextEditingController? controller = TextEditingController();

  CustomInputField(
      {super.key,
      this.label = '',
      required this.inputType,
      this.hint = '',
      this.prefix = '',
      this.suffix = '',
      this.helper = '',
      this.error,
      this.enabled = true,
      this.required = true,
      this.readOnly = false,
      this.controller,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: TextFormField(
        maxLines: null,
        enabled: enabled,
        controller: controller,
        keyboardType: TextInputType.text,
        readOnly: readOnly,
        onTap: onTap,
        validator: (value) {
          if (required && enabled) {
            if (value!.isEmpty) {
              return "required".tr;
            }
          }
          return null;
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusColor: AppColors.primaryColorLow,
            hoverColor: AppColors.primaryColorLow,
            label: Text(label),
            hintText: hint,
            prefixText: prefix,
            suffixText: suffix,
            helperText: helper,
            errorText: error,
            // icon: Text(helper),
            hintStyle: const TextStyle(fontSize: Dimensions.primaryTextSize)),
      ),
    );
  }
}
