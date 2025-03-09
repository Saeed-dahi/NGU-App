import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class RollPage {
  static buildCustomRollPage(
      {required List columns,
      required data,
      required ttf,
      Map<int, pw.TableColumnWidth>? columnWidths,
      pw.Widget? customPageHeader}) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.only(right: 30, bottom: 10),
        theme: pw.ThemeData(textAlign: pw.TextAlign.center),
        pageFormat: PdfPageFormat.roll80,
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                customPageHeader ?? pw.SizedBox(),
                pw.TableHelper.fromTextArray(
                  headers: columns.map((column) => column).toList(),
                  headerStyle: pw.TextStyle(
                      font: ttf, fontSize: 8, fontWeight: pw.FontWeight.bold),
                  headerDecoration:
                      pw.BoxDecoration(color: PdfColor.fromHex('#7F7F7F')),
                  border: pw.TableBorder.all(color: PdfColors.black),
                  data: data,
                  columnWidths: columnWidths,
                  cellStyle: pw.TextStyle(fontSize: 8, font: ttf),
                )
              ]);
        },
      ),
    );

    return pdf;
  }
}
