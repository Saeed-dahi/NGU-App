import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';

class CustomCheckBoxButton extends StatelessWidget {
  final bool value;
  final String label;
  final void Function(bool?)? onChanged;

  const CustomCheckBoxButton(
      {super.key, this.onChanged, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          semanticLabel: 'sdksmdka',
        ),
        Text(
          label.tr,
          style: const TextStyle(fontSize: Dimensions.primaryTextSize),
        ),
      ],
    );
  }
}
