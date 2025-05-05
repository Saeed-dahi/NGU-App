import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomRadioButton extends StatelessWidget {
  final List<String> data;
  final String? selectedValue;
  final void Function(String?)? onChanged;

  const CustomRadioButton(
      {super.key, required this.data, this.selectedValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
