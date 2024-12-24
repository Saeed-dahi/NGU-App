import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/closing_accounts/presentation/pages/closing_account_statement.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';

class ClosingAccountStatementDialog extends StatelessWidget {
  TextEditingController completedProductValue = TextEditingController();
  ClosingAccountStatementDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      inputType: TextInputType.number,
      label: 'completed_product_value'.tr,
      controller: completedProductValue,
      onEditingComplete: () {
        Get.back();
        context.read<TabCubit>().addNewTab(
            title: '${'process'.tr} ${'closing_vouchers'.tr}',
            content: ClosingAccountStatement(
              completedProductValue:
                  double.tryParse(completedProductValue.text),
            ));
      },
    );
  }
}
