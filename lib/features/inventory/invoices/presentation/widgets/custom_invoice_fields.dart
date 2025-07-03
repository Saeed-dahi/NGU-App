import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_account_auto_complete.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
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
                prefix: DateTime.now().year.toString(),
              ),
              CustomInputField(
                label: 'document_number'.tr,
                enabled: enable,
                controller: invoiceFormCubit.documentNumberController,
                error: errors['document_number']?.join('\n'),
                required: false,
              ),
              CustomDatePicker(
                controller: invoiceFormCubit.dateController,
                labelText: 'created_at'.tr,
                enabled: enable,
                error: errors['date']?.join('\n'),
              ),
              CustomAccountAutoComplete(
                enabled: enable,
                initialValue: invoiceFormCubit.accountController.arName ?? '',
                controller: invoiceFormCubit.accountController,
                error: errors['account_id']?.join('\n'),
                label: 'account',
              ),
            ],
          ),
          TableRow(
            children: [
              CustomInputField(
                label: 'address'.tr,
                enabled: enable,
                controller: invoiceFormCubit.addressController,
                error: errors['address']?.join('\n'),
                required: false,
              ),
              CustomInputField(
                label: 'notes'.tr,
                enabled: enable,
                controller: invoiceFormCubit.notesController,
                error: errors['notes']?.join('\n'),
                required: false,
              ),
              CustomDatePicker(
                controller: invoiceFormCubit.dueDateController,
                labelText: 'due_date'.tr,
                enabled: enable,
                error: errors['due_date']?.join('\n'),
                required: false,
              ),
              const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
