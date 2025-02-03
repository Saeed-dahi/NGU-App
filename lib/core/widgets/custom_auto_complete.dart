import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';

class CustomAutoComplete extends StatelessWidget {
  final List<String> data;
  void Function(String)? onSelected;
  final String label;
  final TextEditingValue? initialValue;
  final bool enabled;

  CustomAutoComplete(
      {super.key,
      required this.data,
      this.onSelected,
      required this.label,
      this.initialValue,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        } else {
          return data.where(
            (word) {
              return FormatterClass.normalizeArabic(word)
                  .toLowerCase()
                  .contains(
                    FormatterClass.normalizeArabic(
                        textEditingValue.text.toLowerCase()),
                  );
            },
          );
        }
      },
      onSelected: onSelected,
      initialValue: initialValue,
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        return CustomInputField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          onEditingComplete: onEditingComplete,
          inputType: TextInputType.datetime,
          label: label,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.primaryColor,
          ),
        );
      },
    );
  }
}
