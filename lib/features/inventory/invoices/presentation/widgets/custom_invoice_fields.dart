import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/accounts/presentation/pages/accounts_table.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_account_entity.dart';

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

  _openAccountDialog(BuildContext context, InvoiceAccountEntity query) async {
    final result = await ShowDialog.showCustomDialog(
        context: context,
        content: AccountsTable(
          initValue: query.code,
        ));

    query = InvoiceAccountEntity(
      id: result['account_id'],
      code: result['account_code'],
      arName: result['account_name'],
      enName: result['account_name'],
    );
  }

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
              CustomInputField(
                label: 'account'.tr,
                onTap: () => _openAccountDialog(context, accountController),
                enabled: enable,
                controller: TextEditingController(
                    text:
                        '${accountController.arName} - ${accountController.enName}'),
              ),
              CustomInputField(
                label: 'address'.tr,
                enabled: enable,
                controller: TextEditingController(),
              ),
              CustomInputField(
                label: 'goods_account'.tr,
                onTap: () =>
                    _openAccountDialog(context, goodsAccountController),
                enabled: enable,
                controller:
                    TextEditingController(text: goodsAccountController.arName),
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
