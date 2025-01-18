import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';

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
      // optionsViewBuilder: (context, onSelected, options) {
      //   return Align(
      //     alignment: Alignment.topRight,
      //     child: Material(
      //       child: SizedBox(
      //         width: 300,
      //         height: 200,
      //         child: ListView.separated(
      //           itemBuilder: (BuildContext context, int index) {
      //             return ListTile(
      //               title: Text(options.elementAt(index)),
      //               focusNode: FocusNode(
      //                 canRequestFocus: true,
      //               ),
      //               autofocus: true,
      //               focusColor: Colors.amber,
      //               onTap: () {
      //                 onSelected;
      //               },
      //             );
      //           },
      //           separatorBuilder: (BuildContext context, int index) {
      //             return const Divider();
      //           },
      //           itemCount: options.length,
      //         ),
      //       ),
      //     ),
      //   );
      // },

      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        return CustomInputField(
          controller: controller,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          inputType: TextInputType.datetime,
          label: 'account'.tr,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.primaryColor,
          ),
        );
      },
    );
  }
}
