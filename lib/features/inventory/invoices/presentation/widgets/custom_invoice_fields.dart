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
  final InvoiceAccountEntity accountController;
  final InvoiceAccountEntity goodsAccountController;
  String? natureController;
  final bool enable;

  CustomInvoiceFields(
      {super.key,
      required this.numberController,
      required this.dateController,
      required this.dueDateController,
      required this.notesController,
      required this.accountController,
      required this.goodsAccountController,
      required this.natureController,
      required this.enable});

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
              ),
              CustomDatePicker(
                dateInput: dateController,
                labelText: 'created_at'.tr,
                enabled: enable,
              ),
              CustomDatePicker(
                dateInput: dueDateController,
                labelText: 'due_date'.tr,
                enabled: enable,
              ),
              const SizedBox(),
              CustomInputField(
                label: 'notes'.tr,
                enabled: enable,
                controller: notesController,
              ),
            ],
          ),
          TableRow(
            children: [
              CustomAutoComplete(
                data: context.read<InvoiceBloc>().accountsNameList,
                label: 'account',
                enabled: enable,
                initialValue: TextEditingValue(text: accountController.arName),
                onSelected: (value) {
                  accountController.id =
                      context.read<InvoiceBloc>().getDesiredId(value);
                },
              ),
              CustomInputField(
                label: 'address'.tr,
                enabled: enable,
                controller: TextEditingController(),
              ),
              CustomAutoComplete(
                data: context.read<InvoiceBloc>().accountsNameList,
                label: 'goods_account',
                enabled: enable,
                initialValue:
                    TextEditingValue(text: goodsAccountController.arName),
                onSelected: (value) {
                  goodsAccountController.id =
                      context.read<InvoiceBloc>().getDesiredId(value);
                },
              ),
              const SizedBox(),
              CustomDropdown(
                dropdownValue: getEnumValues(AccountNature.values),
                onChanged: (value) {
                  natureController = value!;
                },
                label: 'invoice_nature'.tr,
                enabled: enable,
                value: natureController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
