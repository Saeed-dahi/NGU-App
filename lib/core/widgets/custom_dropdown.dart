import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/config/constant.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String hint;
  final String prefix;
  final String suffix;
  final String helper;
  final String value;
  final bool enabled;
  final bool required;
  final bool readOnly;
  final List<String> dropdownValue;

  const CustomDropdown(
      {super.key,
      this.label = '',
      this.hint = '',
      this.prefix = '',
      this.suffix = '',
      this.helper = '',
      this.value = '',
      this.enabled = true,
      this.required = true,
      this.readOnly = false,
      required this.dropdownValue});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButtonFormField(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        items: dropdownValue.map(
          (item) {
            return DropdownMenuItem(
              value: item,
              enabled: enabled,
              child: Text(
                item.tr.toString(),
                style:
                    TextStyle(color: enabled ? AppColors.black : Colors.grey),
              ),
            );
          },
        ).toList(),
        value: value == '' ? dropdownValue[0].toString() : value.toString(),
        focusColor: AppColors.transparent,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          label: Text(label),
          hintText: hint,
          prefixText: prefix,
          suffixText: suffix,
          helperText: helper,
          enabled: enabled,

          // icon: Text(helper),
          hintStyle: const TextStyle(fontSize: Dimensions.primaryTextSize),
        ),
        onChanged: (value) {},
        validator: (value) {
          if (required && enabled) {}
          return null;
        },
      ),
    );
  }
}
