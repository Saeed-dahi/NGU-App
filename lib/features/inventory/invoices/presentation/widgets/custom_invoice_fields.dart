import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_account_auto_complete.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_bloc/invoice_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_form_cubit/invoice_form_cubit.dart';

class CustomInvoiceFields extends StatelessWidget {
  final bool enable;
  final Map<String, dynamic> errors;
  final InvoiceFormCubit invoiceFormCubit;
  final InvoiceBloc invoiceBloc;

  const CustomInvoiceFields(
      {super.key,
      required this.enable,
      required this.errors,
      required this.invoiceFormCubit,
      required this.invoiceBloc});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Table(
        children: [
          TableRow(
            children: [
              CustomInputField(
                label: 'invoice_number'.tr,
                enabled: enable,
                controller: invoiceFormCubit.numberController,
                error: errors['invoice_number']?.join('\n'),
                format: FilteringTextInputFormatter.digitsOnly,
              ),
              CustomDatePicker(
                dateInput: invoiceFormCubit.dateController,
                labelText: 'created_at'.tr,
                enabled: enable,
                error: errors['date']?.join('\n'),
              ),
              CustomDatePicker(
                dateInput: invoiceFormCubit.dueDateController,
                labelText: 'due_date'.tr,
                enabled: enable,
                error: errors['due_date']?.join('\n'),
                required: false,
              ),
              const SizedBox(),
              CustomInputField(
                label: 'notes'.tr,
                enabled: enable,
                controller: invoiceFormCubit.notesController,
                error: errors['notes']?.join('\n'),
                required: false,
              ),
            ],
          ),
          TableRow(
            children: [
              CustomAccountAutoComplete(
                enabled: enable,
                initialValue: invoiceFormCubit.accountController.arName ?? '',
                controller: invoiceFormCubit.accountController,
                error: errors['account_id']?.join('\n'),
              ),
              CustomInputField(
                label: 'address'.tr,
                enabled: enable,
                controller: invoiceFormCubit.addressController,
                error: errors['address']?.join('\n'),
                required: false,
              ),
              CustomAccountAutoComplete(
                enabled: enable,
                initialValue:
                    invoiceFormCubit.goodsAccountController.arName ?? '',
                controller: invoiceFormCubit.goodsAccountController,
                error: errors['goods_account_id']?.join('\n'),
              ),
              const SizedBox(),
              CustomDropdown(
                dropdownValue: getEnumValues(AccountNature.values),
                onChanged: (value) {
                  invoiceFormCubit.natureController = value;
                },
                label: 'invoice_nature'.tr,
                enabled: enable,
                value: invoiceFormCubit.natureController,
                error: errors['invoice_nature']?.join('\n'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
