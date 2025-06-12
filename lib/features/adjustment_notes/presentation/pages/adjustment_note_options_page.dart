import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_account_auto_complete.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_bloc/adjustment_note_bloc.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_form_cubit/adjustment_note_form_cubit.dart';

class AdjustmentNoteOptionsPage extends StatelessWidget {
  final bool enableEditing;
  final AdjustmentNoteFormCubit invoiceFormCubit;
  final AdjustmentNoteBloc invoiceBloc;

  final Map<String, dynamic> errors;

  const AdjustmentNoteOptionsPage(
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
              label: 'goods_account',
            ),
            CustomAccountAutoComplete(
              enabled: enableEditing,
              initialValue: invoiceFormCubit.taxAccountController.arName ?? '',
              controller: invoiceFormCubit.taxAccountController,
              error: errors['tax_account_id']?.join('\n'),
              label: 'tax_account',
            ),
            CustomAccountAutoComplete(
              enabled: enableEditing,
              initialValue:
                  invoiceFormCubit.discountAccountController.arName ?? '',
              controller: invoiceFormCubit.discountAccountController,
              error: errors['discount_account_id']?.join('\n'),
              label: 'discount_account',
            ),
          ],
        ),
        TableRow(
          children: [
            CustomInputField(
              label: 'description'.tr,
              controller: invoiceFormCubit.descriptionController,
              enabled: enableEditing,
              error: errors['tax_account_description']?.join('\n'),
              required: false,
            ),
            CustomInputField(
              label: 'tax_amount'.tr,
              enabled: enableEditing,
              controller: invoiceFormCubit.taxAmountController,
              helper: '%',
              format: FilteringTextInputFormatter.digitsOnly,
              error: errors['tax_amount']?.join('\n'),
              readOnly: true,
            ),
            CustomDropdown(
              dropdownValue: getEnumValues(AccountNature.values),
              onChanged: (value) {
                invoiceFormCubit.natureController = value;
              },
              label: 'invoice_nature'.tr,
              value: invoiceFormCubit.natureController,
              error: errors['invoice_nature']?.join('\n'),
            ),
          ],
        ),
      ],
    );
  }
}
