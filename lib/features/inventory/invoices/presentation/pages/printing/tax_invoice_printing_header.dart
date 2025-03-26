import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class CustomInvoicePrintingHeader {
  static pw.Widget getCustomContent(
      {required Font? ttf, required InvoiceEntity invoice}) {
    // Here you can define any custom content
    return pw.Container(
      margin: const pw.EdgeInsets.only(
          left: PdfPageFormat.cm * 3.5, right: PdfPageFormat.cm * 2),
      child: pw.Column(
        children: [
          pw.SizedBox(height: PdfPageFormat.cm * 4.5),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                invoice.invoiceNumber.toString(),
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
              pw.Text(
                '${invoice.account!.arName!} - ${invoice.account!.enName!}',
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
            ],
          ),
          pw.SizedBox(height: PdfPageFormat.cm * 0.5),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                invoice.address!,
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
            ],
          ),
          pw.SizedBox(height: PdfPageFormat.cm * 0.5),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                invoice.date!,
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
              pw.Text(
                '123456789987654321',
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
            ],
          ),
          pw.SizedBox(height: PdfPageFormat.cm * 1),
        ],
      ),
    );
  }
}
