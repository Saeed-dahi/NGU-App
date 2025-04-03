import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class CustomInvoicePrintingHeader {
  static pw.Widget getCustomContent(
      {required Font? ttf, required InvoiceEntity invoice}) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(
          right: PdfPageFormat.cm * 1.5, left: PdfPageFormat.cm * 5),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                invoice.invoiceNumber.toString(),
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
              pw.SizedBox(height: PdfPageFormat.cm * 0.5),
              pw.Text(
                invoice.date!,
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                '${invoice.account!.arName!} - ${invoice.account!.enName!}',
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
              pw.SizedBox(height: PdfPageFormat.cm * 0.25),
              pw.Text(
                invoice.address!,
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
              pw.SizedBox(height: PdfPageFormat.cm * 0.25),
              pw.Text(
                '123456789987654321',
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
