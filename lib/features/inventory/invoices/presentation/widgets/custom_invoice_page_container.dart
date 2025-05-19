import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/core/utils/enums.dart';

class CustomInvoicePageContainer extends StatelessWidget {
  final Widget child;
  final String type;
  const CustomInvoicePageContainer(
      {super.key, required this.child, required this.type});

  Color _getBackgroundColor(String type) {
    if (InvoiceType.purchase.name == type) {
      return Colors.green;
    }
    if (InvoiceType.sales.name == type) {
      return Colors.blue;
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
