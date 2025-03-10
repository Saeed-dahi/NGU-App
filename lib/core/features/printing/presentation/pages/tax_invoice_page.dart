import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TaxInvoicePage {
  static buildCustomTaxInvoicePage(
      {required List columns, required data, required ttf}) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageTheme: const pw.PageTheme(
          textDirection: pw.TextDirection.rtl,
          margin: pw.EdgeInsets.only(left: 10),
        ),
        build: (pw.Context context) {
          List<pw.Widget> content = [];

          content.add(pw.Container(
            margin: const pw.EdgeInsets.only(
                left: PdfPageFormat.cm * 3, right: PdfPageFormat.cm * 2),
            child: pw.Column(
              children: [
                pw.SizedBox(height: PdfPageFormat.cm * 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      '5247',
                      style: pw.TextStyle(fontSize: 9, font: ttf),
                    ),
                    pw.Text(
                      'السويدان لتجارة المواد الغذائية',
                      style: pw.TextStyle(fontSize: 9, font: ttf),
                    ),
                  ],
                ),
                pw.SizedBox(height: PdfPageFormat.cm * 0.5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                      'أبو ظبي',
                      style: pw.TextStyle(fontSize: 10, font: ttf),
                    ),
                  ],
                ),
                pw.SizedBox(height: PdfPageFormat.cm * 0.5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      '10/03/2025',
                      style: pw.TextStyle(fontSize: 10, font: ttf),
                    ),
                    pw.Text(
                      '123456789987654321',
                      style: pw.TextStyle(fontSize: 10, font: ttf),
                    ),
                  ],
                ),
                pw.SizedBox(height: PdfPageFormat.cm * 0.5),
              ],
            ),
          ));

          content.add(
            pw.TableHelper.fromTextArray(
                headers: [],
                border: pw.TableBorder.all(width: 0, color: PdfColors.white),
                data: data,
                cellStyle: pw.TextStyle(fontSize: 8, font: ttf),
                columnWidths: {1: const pw.FixedColumnWidth(120)}),
          );

          return content;
        },
      ),
    );

    return pdf;
  }
}
