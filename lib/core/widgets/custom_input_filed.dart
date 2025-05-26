// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/app_config/constant.dart';

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
  final bool autofocus;
  final bool isCenterLabel;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType inputType;
  TextInputFormatter? format;
  VoidCallback? onEditingComplete;

  TextEditingController? controller = TextEditingController();

  CustomInputField(
      {super.key,
      this.label = '',
      this.inputType = TextInputType.text,
      this.format,
      this.hint = '',
      this.prefix = '',
      this.suffix = '',
      this.helper = '',
      this.error,
      this.enabled = true,
      this.required = true,
      this.readOnly = false,
      this.autofocus = true,
      this.isCenterLabel = false,
      this.controller,
      this.onTap,
      this.onChanged,
      this.focusNode,
      this.prefixIcon,
      this.onEditingComplete,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: TextFormField(
        maxLines: null,
        autofocus: autofocus,
        focusNode: focusNode,
        enabled: enabled,
        controller: controller,
        keyboardType: inputType,
        inputFormatters: [
          format ?? FilteringTextInputFormatter.singleLineFormatter
        ],
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
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
          onEditingComplete?.call();
        },
        onTapAlwaysCalled: true,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        autovalidateMode:
            required ? AutovalidateMode.always : AutovalidateMode.disabled,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusColor: AppColors.primaryColorLow,
            hoverColor: AppColors.primaryColorLow,
            label: isCenterLabel ? Center(child: Text(label)) : Text(label),
            hintText: hint,
            prefixText: prefix,
            prefixStyle: const TextStyle(color: AppColors.primaryColorLow),
            suffixText: suffix,
            helperText: helper,
            errorText: error,
            prefixIcon: prefixIcon,
            hintStyle: const TextStyle(fontSize: Dimensions.primaryTextSize)),
      ),
    );
  }
}
