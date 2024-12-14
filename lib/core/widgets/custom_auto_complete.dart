import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';

class CustomAutoComplete extends StatelessWidget {
  final List<String> data;
  void Function(String)? onSelected;
  final String label;

  CustomAutoComplete(
      {super.key, required this.data, this.onSelected, required this.label});

  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        } else {
          return data.where((word) =>
              FormatterClass.normalizeArabic(word).toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ));
        }
      },
      onSelected: onSelected,
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: true,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusColor: AppColors.primaryColorLow,
              hoverColor: AppColors.primaryColorLow,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.primaryColor,
              ),
              labelText: label.tr,
              hintStyle: const TextStyle(fontSize: Dimensions.primaryTextSize)),
        );
      },
    );
  }
}
