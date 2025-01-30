import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';

class InvoiceOptionsPage extends StatelessWidget {
  const InvoiceOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            CustomInputField(
              label: 'goods_account'.tr,
            ),
            CustomInputField(
              label: 'description'.tr,
            ),
            const SizedBox()
          ],
        ),
        TableRow(
          children: [
            CustomInputField(
              label: 'tax_account'.tr,
            ),
            CustomInputField(
              label: 'tax_amount'.tr,
              helper: '%',
            ),
            CustomInputField(
              label: 'description'.tr,
            ),
          ],
        ),
        TableRow(
          children: [
            CustomInputField(
              label: 'discount_account'.tr,
            ),
            CustomInputField(
              label: 'discount_amount'.tr,
              helper: '%',
            ),
            CustomInputField(
              label: 'description'.tr,
            ),
          ],
        ),
      ],
    );
  }
}
