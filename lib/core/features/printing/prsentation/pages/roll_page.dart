import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

class RollPage {
  static buildCustomRollPage(List columns, data, ttf) async {
    final backgroundImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List(),
    );
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          buildBackground: (context) {
            return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Opacity(
                        opacity: 0.3,
                        child: pw.Image(
                          backgroundImage,
                        ),
                      )
                    ])
              ],
            );
          },
        ),
        pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context) {
          return pw.TableHelper.fromTextArray(
            headers: columns,
            headerDecoration:
                pw.BoxDecoration(color: PdfColor.fromHex('ffd59a4c')),
            border: pw.TableBorder.all(color: PdfColors.grey),
            oddRowDecoration: const pw.BoxDecoration(color: PdfColors.grey200),

            data: data,
            cellStyle: pw.TextStyle(font: ttf), // Apply Arabic font to cells
            headerStyle: pw.TextStyle(font: ttf),
          );
        },
      ),
    );

    return pdf;
  }
}
