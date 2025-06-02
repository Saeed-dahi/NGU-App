import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class CustomInvoicePrintingFooter {
  static pw.Widget getCustomContent(
      {required Font? ttf, required InvoiceEntity invoice}) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(
          left: PdfPageFormat.cm * 5,
          right: PdfPageFormat.cm * 1,
          bottom: PdfPageFormat.cm * 5),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                invoice.subTotal.toString(),
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
              pw.Text(
                invoice.taxAmount.toString(),
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
              pw.Text(
                invoice.total.toString(),
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                ' 20',
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                'وخمسمئة وخمسين الف فقط عشرة الاآف',
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
