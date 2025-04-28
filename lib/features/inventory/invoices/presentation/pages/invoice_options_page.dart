import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_account_auto_complete.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_bloc/invoice_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_form_cubit/invoice_form_cubit.dart';

class InvoiceOptionsPage extends StatelessWidget {
  final bool enableEditing;
  final InvoiceFormCubit invoiceFormCubit;
  final InvoiceBloc invoiceBloc;

  final Map<String, dynamic> errors;

  const InvoiceOptionsPage(
      {super.key,
      required this.enableEditing,
      required this.errors,
      required this.invoiceBloc,
      required this.invoiceFormCubit});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            CustomAccountAutoComplete(
              enabled: enableEditing,
              initialValue:
                  invoiceFormCubit.goodsAccountController.arName ?? '',
              error: errors['goods_account']?.join('\n'),
              controller: invoiceFormCubit.goodsAccountController,
            ),
            CustomInputField(
              label: 'description'.tr,
              enabled: enableEditing,
              controller: invoiceFormCubit.goodsAccountDescriptionController,
              error: errors['description']?.join('\n'),
            ),
            const SizedBox()
          ],
        ),
        TableRow(
          children: [
            CustomAccountAutoComplete(
              enabled: enableEditing,
              initialValue: invoiceFormCubit.taxAccountController.arName ?? '',
              controller: invoiceFormCubit.taxAccountController,
              error: errors['total_tax_account']?.join('\n'),
            ),
            CustomInputField(
              label: 'tax_amount'.tr,
              enabled: enableEditing,
              controller: invoiceFormCubit.taxAmountController,
              helper: '%',
              format: FilteringTextInputFormatter.digitsOnly,
              error: errors['tax_amount']?.join('\n'),
            ),
            CustomInputField(
              label: 'description'.tr,
              controller: invoiceFormCubit.taxAccountDescriptionController,
              enabled: enableEditing,
              error: errors['tax_account_description']?.join('\n'),
              required: false,
            ),
          ],
        ),
        TableRow(
          children: [
            CustomAccountAutoComplete(
              enabled: enableEditing,
              initialValue:
                  invoiceFormCubit.discountAccountController.arName ?? '',
              controller: invoiceFormCubit.discountAccountController,
              error: errors['total_discount_account']?.join('\n'),
            ),
            CustomInputField(
              label: 'discount_amount'.tr,
              enabled: enableEditing,
              controller: invoiceFormCubit.discountAmountController,
              helper: '%',
              format: FilteringTextInputFormatter.digitsOnly,
              error: errors['discount_amount']?.join('\n'),
            ),
            CustomInputField(
              label: 'description'.tr,
              controller: invoiceFormCubit.discountAccountDescriptionController,
              enabled: enableEditing,
              error: errors['discount_account_description']?.join('\n'),
              required: false,
            ),
          ],
        ),
      ],
    );
  }
}
