import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_container.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';

class InvoicePrintPage extends StatelessWidget {
  const InvoicePrintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            CustomContainer(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('invoice_printer'.tr),
                    CustomDropdown(
                      dropdownValue: ['طابعة ١', 'طابعة ٢'],
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ),
            CustomContainer(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('receipt_printer'.tr),
                    CustomDropdown(
                      dropdownValue: ['طابعة ٢', 'طابعة 1', 'طابعة 3'],
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
