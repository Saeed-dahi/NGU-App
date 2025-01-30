import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/accounts/presentation/pages/accounts_table.dart';

class CustomInvoiceFields extends StatelessWidget {
  final bool enable;
  const CustomInvoiceFields({super.key, required this.enable});

  _openAccountDialog(BuildContext context) async {
    final result = await ShowDialog.showCustomDialog(
        context: context,
        content: const AccountsTable(
          initValue: 'assets',
        ));
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
              ),
              CustomDatePicker(
                dateInput: TextEditingController(),
                labelText: 'created_at'.tr,
                enabled: enable,
              ),
              CustomDatePicker(
                dateInput: TextEditingController(),
                labelText: 'due_date'.tr,
                enabled: enable,
              ),
              const SizedBox(),
              CustomInputField(
                label: 'notes'.tr,
                enabled: enable,
              ),
            ],
          ),
          TableRow(
            children: [
              CustomInputField(
                label: 'account'.tr,
                onTap: () => _openAccountDialog(context),
                enabled: enable,
              ),
              CustomInputField(
                label: 'address'.tr,
                enabled: enable,
              ),
              CustomInputField(
                label: 'goods_account'.tr,
                onTap: () => _openAccountDialog(context),
                enabled: enable,
              ),
              const SizedBox(),
              CustomDropdown(
                dropdownValue: getEnumValues(AccountNature.values),
                onChanged: (value) {},
                label: 'invoice_nature'.tr,
                enabled: enable,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
