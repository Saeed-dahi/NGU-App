import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/custom_radio_button.dart';

class MultipleChequesForm extends StatelessWidget {
  const MultipleChequesForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Table(
      children: [
        TableRow(children: [
          Column(
            children: [
              CustomInputField(
                inputType: TextInputType.name,
                // controller: chequeFormCubit.amountController,
                label: 'cheques_count'.tr,
                format: FilteringTextInputFormatter.digitsOnly,
              ),
              CustomInputField(
                inputType: TextInputType.name,
                // controller: chequeFormCubit.amountController,
                label: 'each_payment'.tr,
                format: FilteringTextInputFormatter.digitsOnly,
              ),
              CustomInputField(
                inputType: TextInputType.name,
                // controller: chequeFormCubit.amountController,
                label: 'first_payment'.tr,
                format: FilteringTextInputFormatter.digitsOnly,
              ),
              CustomInputField(
                inputType: TextInputType.name,
                // controller: chequeFormCubit.amountController,
                label: 'last_payment'.tr,
                format: FilteringTextInputFormatter.digitsOnly,
              ),
            ],
          ),
          CustomRadioButton(
            data: getEnumValues(ChequePaymentCases.values),
            label: 'payment_way'.tr,
          ),
        ]),
      ],
    ));
  }
}
