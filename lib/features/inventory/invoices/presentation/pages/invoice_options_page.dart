import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';

class InvoiceOptionsPage extends StatelessWidget {
  final bool enableEditing;
  const InvoiceOptionsPage({super.key, required this.enableEditing});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            CustomInputField(
              label: 'goods_account'.tr,
              enabled: enableEditing,
            ),
            CustomInputField(
              label: 'description'.tr,
              enabled: enableEditing,
            ),
            const SizedBox()
          ],
        ),
        TableRow(
          children: [
            CustomInputField(
              label: 'tax_account'.tr,
              enabled: enableEditing,
            ),
            CustomInputField(
              label: 'tax_amount'.tr,
              enabled: enableEditing,
              helper: '%',
            ),
            CustomInputField(
              label: 'description'.tr,
              enabled: enableEditing,
            ),
          ],
        ),
        TableRow(
          children: [
            CustomInputField(
              label: 'discount_account'.tr,
              enabled: enableEditing,
            ),
            CustomInputField(
              label: 'discount_amount'.tr,
              enabled: enableEditing,
              helper: '%',
            ),
            CustomInputField(
              label: 'description'.tr,
              enabled: enableEditing,
            ),
          ],
        ),
      ],
    );
  }
}
