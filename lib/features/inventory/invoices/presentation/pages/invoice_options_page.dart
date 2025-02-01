import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_auto_complete.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_account_entity.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/bloc/invoice_bloc.dart';

class InvoiceOptionsPage extends StatelessWidget {
  final bool enableEditing;

  final InvoiceAccountEntity goodsAccountController;
  final TextEditingController goodsAccountDescriptionController;

  final InvoiceAccountEntity taxAccountController;
  final TextEditingController taxAmountController;
  final TextEditingController taxAccountDescriptionController;

  final InvoiceAccountEntity discountAccountController;
  final TextEditingController discountAmountController;
  final TextEditingController discountAccountDescriptionController;

  final InvoiceAccountEntity accountController;

  const InvoiceOptionsPage(
      {super.key,
      required this.enableEditing,
      required this.goodsAccountController,
      required this.goodsAccountDescriptionController,
      required this.taxAccountController,
      required this.taxAmountController,
      required this.taxAccountDescriptionController,
      required this.discountAccountController,
      required this.discountAmountController,
      required this.discountAccountDescriptionController,
      required this.accountController});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            CustomAutoComplete(
              data: context.read<InvoiceBloc>().accountsNameList,
              label: 'goods_account',
              enabled: enableEditing,
              initialValue:
                  TextEditingValue(text: goodsAccountController.arName),
              onSelected: (value) {
                goodsAccountController.id =
                    context.read<InvoiceBloc>().getDesiredId(value);
              },
            ),
            CustomInputField(
              label: 'description'.tr,
              enabled: enableEditing,
            ),
            const SizedBox()
          ],
        ),
        TableRow(
          children: [
            CustomAutoComplete(
              data: context.read<InvoiceBloc>().accountsNameList,
              label: 'tax_account',
              enabled: enableEditing,
              initialValue: TextEditingValue(text: taxAccountController.arName),
              onSelected: (value) {
                taxAccountController.id =
                    context.read<InvoiceBloc>().getDesiredId(value);
              },
            ),
            CustomInputField(
              label: 'tax_amount'.tr,
              enabled: enableEditing,
              helper: '%',
            ),
            CustomInputField(
              label: 'description'.tr,
              enabled: enableEditing,
            ),
          ],
        ),
        TableRow(
          children: [
            CustomAutoComplete(
              data: context.read<InvoiceBloc>().accountsNameList,
              label: 'discount_account',
              enabled: enableEditing,
              initialValue:
                  TextEditingValue(text: discountAccountController.arName),
              onSelected: (value) {
                discountAccountController.id =
                    context.read<InvoiceBloc>().getDesiredId(value);
              },
            ),
            CustomInputField(
              label: 'discount_amount'.tr,
              enabled: enableEditing,
              helper: '%',
            ),
            CustomInputField(
              label: 'description'.tr,
              enabled: enableEditing,
            ),
          ],
        ),
      ],
    );
  }
}
