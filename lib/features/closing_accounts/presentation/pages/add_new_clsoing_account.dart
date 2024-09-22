import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ngu_app/app/config/constant.dart';

import 'package:ngu_app/core/widgets/custom_input_filed.dart';

class AddNewClosingAccount extends StatelessWidget {
  final bool enableEditing = false;
  const AddNewClosingAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'add_new_account'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: Dimensions.primaryTextSize),
        ),
        const SizedBox(
          height: 10,
        ),
        accountBasicInfo(context),
      ],
    );
  }

  ListView accountBasicInfo(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        CustomInputField(
          inputType: TextInputType.name,
          helper: 'ar_name'.tr,
          controller: TextEditingController(text: '123'),
        ),
        CustomInputField(
          inputType: TextInputType.name,
          helper: 'en_name'.tr,
          controller: TextEditingController(text: '123'),
        ),
      ],
    );
  }
}
