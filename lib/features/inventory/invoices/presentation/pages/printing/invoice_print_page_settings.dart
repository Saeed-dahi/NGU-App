import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/features/printing/presentation/bloc/printing_bloc.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_container.dart';
import 'package:ngu_app/core/widgets/custom_elevated_button.dart';
import 'package:ngu_app/core/widgets/loaders.dart';

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
        if (state is LoadedPrinterState) {
          return CustomContainer(
            child: CustomElevatedButton(
              color: AppColors.primaryColorLow,
              text: context.read<PrintingBloc>().receiptPrinter!.name,
              onPressed: () => context
                  .read<PrintingBloc>()
                  .pickPrinter(context, printerType, true),
            ),
          );
        }
        if (state is ErrorPrinterState) {
          return CustomContainer(
            child: CustomElevatedButton(
              color: AppColors.red,
              text: state.error,
              onPressed: () => context
                  .read<PrintingBloc>()
                  .pickPrinter(context, printerType, false),
            ),
          );
        }
        return Center(
          child: Loaders.loading(),
        );
      },
    );
  }

  Widget _customTaxInvoicePrinterWidget({required String printerType}) {
    return BlocBuilder<PrintingBloc, PrintingState>(
      builder: (context, state) {
        if (state is LoadedPrinterState) {
          return CustomContainer(
            child: CustomElevatedButton(
              color: AppColors.primaryColorLow,
              text: context.read<PrintingBloc>().taxInvoicePrinter?.name ??
                  'No Data',
              onPressed: () => context
                  .read<PrintingBloc>()
                  .pickPrinter(context, printerType, true),
            ),
          );
        }
        if (state is ErrorPrinterState) {
          return CustomContainer(
            child: CustomElevatedButton(
              color: AppColors.red,
              text: state.error,
              onPressed: () => context
                  .read<PrintingBloc>()
                  .pickPrinter(context, printerType, false),
            ),
          );
        }
        return Center(
          child: Loaders.loading(),
        );
      },
    );
  }
}
