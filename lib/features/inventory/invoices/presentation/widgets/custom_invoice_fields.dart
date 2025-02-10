import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_auto_complete.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_account_entity.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/bloc/invoice_bloc.dart';

class CustomInvoiceFields extends StatelessWidget {
  final TextEditingController numberController;
  final TextEditingController dateController;
  final TextEditingController dueDateController;
  final TextEditingController notesController;
  final TextEditingController addressController;
  final InvoiceAccountEntity accountController;
  final InvoiceAccountEntity goodsAccountController;
  final bool enable;
  final Map<String, dynamic> errors;

  const CustomInvoiceFields(
      {super.key,
      required this.numberController,
      required this.dateController,
      required this.dueDateController,
      required this.notesController,
      required this.addressController,
      required this.accountController,
      required this.goodsAccountController,
      required this.enable,
      required this.errors});

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
                controller: numberController,
                error: errors['invoice_number']?.join('\n'),
                format: FilteringTextInputFormatter.digitsOnly,
              ),
              CustomDatePicker(
                dateInput: dateController,
                labelText: 'created_at'.tr,
                enabled: enable,
                error: errors['date']?.join('\n'),
              ),
              CustomDatePicker(
                dateInput: dueDateController,
                labelText: 'due_date'.tr,
                enabled: enable,
                error: errors['due_date']?.join('\n'),
              ),
              const SizedBox(),
              CustomInputField(
                label: 'notes'.tr,
                enabled: enable,
                controller: notesController,
                error: errors['notes']?.join('\n'),
              ),
            ],
          ),
          TableRow(
            children: [
              CustomAutoComplete(
                data: context.read<InvoiceBloc>().accountsNameList,
                label: 'account'.tr,
                enabled: enable,
                initialValue: TextEditingValue(text: accountController.arName!),
                onSelected: (value) {
                  accountController.id =
                      context.read<InvoiceBloc>().getDesiredId(value);
                },
                error: errors['account']?.join('\n'),
              ),
              CustomInputField(
                label: 'address'.tr,
                enabled: enable,
                controller: addressController,
                error: errors['address']?.join('\n'),
              ),
              CustomAutoComplete(
                data: context.read<InvoiceBloc>().accountsNameList,
                label: 'goods_account'.tr,
                enabled: enable,
                initialValue:
                    TextEditingValue(text: goodsAccountController.arName!),
                onSelected: (value) {
                  goodsAccountController.id =
                      context.read<InvoiceBloc>().getDesiredId(value);
                },
                error: errors['goods_account']?.join('\n'),
              ),
              const SizedBox(),
              CustomDropdown(
                dropdownValue: getEnumValues(AccountNature.values),
                onChanged: (value) {
                  context.read<InvoiceBloc>().natureController = value;
                },
                label: 'invoice_nature'.tr,
                enabled: enable,
                value: context.read<InvoiceBloc>().natureController,
                error: errors['invoice_nature']?.join('\n'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
