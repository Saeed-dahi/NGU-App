import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/core/utils/enums.dart';

class CustomAdjustmentNotePageContainer extends StatelessWidget {
  final Widget child;
  final String type;
  const CustomAdjustmentNotePageContainer(
      {super.key, required this.child, required this.type});

  Color _getBackgroundColor(String type) {
    if (InvoiceType.purchase.name == type) {
      return Colors.green;
    }
    if (InvoiceType.sales.name == type) {
      return Colors.blue;
    }
    if (InvoiceType.sales_return.name == type) {
      return Colors.red;
    }
    if (InvoiceType.purchase_return.name == type) {
      return Colors.purple;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
            right: Dimensions.primaryPadding, left: Dimensions.primaryPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.borderRadius),
          color: _getBackgroundColor(type).withAlpha(20),
        ),
        child: child);
  }
}
