import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';

class CustomRadioButton extends StatelessWidget {
  final List<String> data;
  final String? selectedValue;
  final String label;
  final void Function(String?)? onChanged;

  const CustomRadioButton(
      {super.key,
      required this.data,
      this.selectedValue,
      this.onChanged,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: Dimensions.primaryTextSize),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return RadioListTile<String>(
              title: Text(data[index].tr),
              value: data[index],
              groupValue: selectedValue,
              onChanged: onChanged,
            );
          },
        ),
      ],
    );
  }
}
