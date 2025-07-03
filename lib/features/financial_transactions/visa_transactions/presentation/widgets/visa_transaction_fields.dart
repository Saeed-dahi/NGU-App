import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_account_auto_complete.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';

class VisaTransactionFields extends StatefulWidget {
  final bool enableEditing;

  const VisaTransactionFields({super.key, required this.enableEditing});

  @override
  State<VisaTransactionFields> createState() => _VisaTransactionFieldsState();
}

class _VisaTransactionFieldsState extends State<VisaTransactionFields> {
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
                CustomInputField(
                  label: 'commission_rate'.tr,
                  enabled: widget.enableEditing,
                  controller: TextEditingController(),
                  // error: _invoiceCommissionBloc
                  //     .getValidationErrors['commission_rate']
                  //     ?.join('\n'),
                ),
                CustomInputField(
                  label: 'tax_amount'.tr,
                  enabled: widget.enableEditing,
                  controller: TextEditingController(),
                  // error: _invoiceCommissionBloc
                  //     .getValidationErrors['commission_rate']
                  //     ?.join('\n'),
                ),
                CustomInputField(
                  label: 'net_amount'.tr,
                  enabled: widget.enableEditing,
                  controller: TextEditingController(),
                  // error: _invoiceCommissionBloc
                  //     .getValidationErrors['commission_rate']
                  //     ?.join('\n'),
                ),
              ],
            ),
            TableRow(children: [
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
                label: 'visa_account'.tr,
              ),
              CustomAccountAutoComplete(
                enabled: widget.enableEditing,
                initialValue: '',
                // error: _invoiceCommissionBloc.getValidationErrors['agent_id']
                //     ?.join('\n'),
                controller: TextEditingController(),
                label: 'commission_account'.tr,
              ),
              CustomAccountAutoComplete(
                enabled: widget.enableEditing,
                initialValue: '',
                // error: _invoiceCommissionBloc.getValidationErrors['agent_id']
                //     ?.join('\n'),
                controller: TextEditingController(),
                label: 'tax_account'.tr,
              ),
              CustomInputField(
                label: 'notes'.tr,
                enabled: widget.enableEditing,
                controller: TextEditingController(),
                // error: _invoiceCommissionBloc
                //     .getValidationErrors['commission_rate']
                //     ?.join('\n'),
              ),
            ]),
          ],
        ),
      ],
    );
  }
}
