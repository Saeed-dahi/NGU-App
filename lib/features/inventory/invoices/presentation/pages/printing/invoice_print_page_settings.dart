import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_container.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';

class InvoicePrintPageSettings extends StatelessWidget {
  const InvoicePrintPageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            CustomContainer(
              child: CustomDropdown(
                dropdownValue: const ['طابعة ١', 'طابعة ٢'],
                label: 'invoice_printer'.tr,
                onChanged: (value) {},
              ),
            ),
            CustomContainer(
              child: CustomDropdown(
                dropdownValue: const ['طابعة ١', 'طابعة ٢'],
                label: 'receipt_printer'.tr,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
