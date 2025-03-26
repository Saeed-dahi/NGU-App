import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class A4PrintingHeader {
  static pw.Widget getCustomContent(
      {required Font? ttf, required InvoiceEntity invoice}) {
    // Here you can define any custom content
    return pw.Container(
      margin: const pw.EdgeInsets.all(Dimensions.primaryPadding),
      padding: const pw.EdgeInsets.all(Dimensions.primaryPadding),
      decoration: const pw.BoxDecoration(
          color: PdfColors.grey100,
          borderRadius: pw.BorderRadius.all(
              pw.Radius.circular(Dimensions.primaryRadius))),
      child: pw.Column(
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                '${invoice.account!.arName!} - ${invoice.account!.enName!}',
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
              pw.Text(
                invoice.address!,
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                '123456789987654321',
                style: pw.TextStyle(
                    fontSize: Dimensions.printingLargeTextSize, font: ttf),
              ),
              pw.Text(
                invoice.date!,
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
