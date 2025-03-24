import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/features/printing/presentation/bloc/printing_bloc.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_container.dart';
import 'package:ngu_app/core/widgets/custom_elevated_button.dart';

class InvoicePrintPageSettings extends StatelessWidget {
  const InvoicePrintPageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            _customReceiptPrinterWidget(printerType: PrinterType.receipt.name),
            _customTaxInvoicePrinterWidget(
                printerType: PrinterType.tax_invoice.name),
          ],
        ),
      ],
    );
  }

  Widget _customReceiptPrinterWidget({required String printerType}) {
    return BlocBuilder<PrintingBloc, PrintingState>(
      builder: (context, state) {
        return CustomContainer(
          child: CustomElevatedButton(
            color: AppColors.primaryColorLow,
            text: context.read<PrintingBloc>().receiptPrinter?.name ??
                'not_found'.tr,
            onPressed: () => _onPressed(context, printerType,
                isExisting:
                    context.read<PrintingBloc>().receiptPrinter != null),
          ),
        );
      },
    );
  }

  Widget _customTaxInvoicePrinterWidget({required String printerType}) {
    return BlocBuilder<PrintingBloc, PrintingState>(
      builder: (context, state) {
        return CustomContainer(
          child: CustomElevatedButton(
            color: AppColors.primaryColorLow,
            text: context.read<PrintingBloc>().taxInvoicePrinter?.name ??
                'not_found'.tr,
            onPressed: () => _onPressed(context, printerType,
                isExisting:
                    context.read<PrintingBloc>().taxInvoicePrinter != null),
          ),
        );
      },
    );
  }

  _onPressed(BuildContext context, String printerType,
      {bool isExisting = false}) {
    context.read<PrintingBloc>().pickPrinter(context, printerType, isExisting);
  }
}
