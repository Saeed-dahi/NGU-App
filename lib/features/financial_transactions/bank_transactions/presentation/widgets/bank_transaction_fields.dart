import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_account_auto_complete.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';

class BankTransactionFields extends StatefulWidget {
  final bool enableEditing;

  const BankTransactionFields({super.key, required this.enableEditing});

  @override
  State<BankTransactionFields> createState() => _BankTransactionFieldsState();
}

class _BankTransactionFieldsState extends State<BankTransactionFields> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _pageBody(context);
  }

  Widget _pageBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Table(
          children: [
            TableRow(
              children: [
                CustomInputField(
                  label: 'document_number'.tr,
                  enabled: widget.enableEditing,
                  controller: TextEditingController(),
                  // error: _invoiceCommissionBloc
                  //     .getValidationErrors['commission_rate']
                  //     ?.join('\n'),
                ),
                CustomInputField(
                  label: 'gross_amount'.tr,
                  enabled: widget.enableEditing,
                  controller: TextEditingController(),
                  // error: _invoiceCommissionBloc
                  //     .getValidationErrors['commission_rate']
                  //     ?.join('\n'),
                ),
                const SizedBox(),
              ],
            ),
            TableRow(
              children: [
                CustomDatePicker(
                    controller: TextEditingController(), labelText: 'date'.tr),
                CustomInputField(
                  label: 'commission_amount'.tr,
                  enabled: widget.enableEditing,
                  controller: TextEditingController(),
                  required: false,
                  // error: _invoiceCommissionBloc
                  //     .getValidationErrors['commission_rate']
                  //     ?.join('\n'),
                ),
                const SizedBox(),
              ],
            ),
            TableRow(
              children: [
                CustomAccountAutoComplete(
                  enabled: widget.enableEditing,
                  initialValue: '',
                  // error: _invoiceCommissionBloc.getValidationErrors['agent_id']
                  //     ?.join('\n'),
                  controller: TextEditingController(),
                  label: 'bank_account'.tr,
                ),
                CustomAccountAutoComplete(
                  enabled: widget.enableEditing,
                  initialValue: '',
                  // error: _invoiceCommissionBloc.getValidationErrors['agent_id']
                  //     ?.join('\n'),
                  controller: TextEditingController(),
                  label: 'issued_from_account'.tr,
                ),
                CustomAccountAutoComplete(
                  enabled: widget.enableEditing,
                  initialValue: '',
                  // error: _invoiceCommissionBloc.getValidationErrors['agent_id']
                  //     ?.join('\n'),
                  controller: TextEditingController(),
                  label: 'issued_to_account'.tr,
                ),
              ],
            ),
            TableRow(
              children: [
                CustomDropdown(
                  dropdownValue: getEnumValues(TransactionNature.values),
                  label: 'transaction_nature'.tr,
                  onChanged: (value) {},
                ),
                CustomDropdown(
                  dropdownValue: getEnumValues(TransactionStatus.values),
                  label: 'transaction_status'.tr,
                  onChanged: (value) {},
                ),
                CustomInputField(
                  label: 'notes'.tr,
                  enabled: widget.enableEditing,
                  controller: TextEditingController(),
                  // error: _invoiceCommissionBloc
                  //     .getValidationErrors['commission_rate']
                  //     ?.join('\n'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
