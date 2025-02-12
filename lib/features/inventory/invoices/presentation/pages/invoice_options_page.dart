import 'package:flutter/services.dart';
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

  InvoiceAccountEntity taxAccountController;
  final TextEditingController taxAmountController;
  final TextEditingController taxAccountDescriptionController;

  InvoiceAccountEntity discountAccountController;
  final TextEditingController discountAmountController;
  final TextEditingController discountAccountDescriptionController;

  final Map<String, dynamic> errors;

  InvoiceOptionsPage(
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
      required this.errors});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            CustomAutoComplete(
              data: context.read<InvoiceBloc>().accountsNameList,
              label: 'goods_account'.tr,
              enabled: enableEditing,
              initialValue:
                  TextEditingValue(text: goodsAccountController.arName ?? ''),
              onSelected: (value) {
                goodsAccountController.id =
                    context.read<InvoiceBloc>().getDesiredId(value);
              },
              error: errors['goods_account']?.join('\n'),
            ),
            CustomInputField(
              label: 'description'.tr,
              enabled: enableEditing,
              controller: goodsAccountDescriptionController,
              error: errors['description']?.join('\n'),
            ),
            const SizedBox()
          ],
        ),
        TableRow(
          children: [
            CustomAutoComplete(
              data: context.read<InvoiceBloc>().accountsNameList,
              label: 'tax_account'.tr,
              enabled: enableEditing,
              initialValue:
                  TextEditingValue(text: taxAccountController.arName ?? ''),
              onSelected: (value) {
                taxAccountController.id =
                    context.read<InvoiceBloc>().getDesiredId(value);
                taxAccountController =
                    taxAccountController.copyWith(arName: value);
              },
              error: errors['total_tax_account']?.join('\n'),
            ),
            CustomInputField(
              label: 'tax_amount'.tr,
              enabled: enableEditing,
              controller: taxAmountController,
              helper: '%',
              format: FilteringTextInputFormatter.digitsOnly,
              error: errors['tax_amount']?.join('\n'),
            ),
            CustomInputField(
              label: 'description'.tr,
              controller: taxAccountDescriptionController,
              enabled: enableEditing,
              error: errors['tax_account_description']?.join('\n'),
            ),
          ],
        ),
        TableRow(
          children: [
            CustomAutoComplete(
              data: context.read<InvoiceBloc>().accountsNameList,
              label: 'discount_account'.tr,
              enabled: enableEditing,
              initialValue: TextEditingValue(
                  text: discountAccountController.arName ?? ''),
              onSelected: (value) {
                discountAccountController.id =
                    context.read<InvoiceBloc>().getDesiredId(value);
                discountAccountController =
                    discountAccountController.copyWith(arName: value);
              },
              error: errors['total_discount_account']?.join('\n'),
            ),
            CustomInputField(
              label: 'discount_amount'.tr,
              enabled: enableEditing,
              controller: discountAmountController,
              helper: '%',
              format: FilteringTextInputFormatter.digitsOnly,
              error: errors['discount_amount']?.join('\n'),
            ),
            CustomInputField(
              label: 'description'.tr,
              controller: discountAccountDescriptionController,
              enabled: enableEditing,
              error: errors['discount_account_description']?.join('\n'),
            ),
          ],
        ),
      ],
    );
  }
}
