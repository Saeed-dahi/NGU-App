import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

class A4Page {
  static buildCustomA4Page(
      {required List columns, required data, required ttf}) async {
    final headerImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/header.jpeg')).buffer.asUint8List(),
    );
    final backgroundImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List(),
    );
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        header: (context) {
          return pw.Image(
            headerImage,
          );
        },
        pageTheme: pw.PageTheme(
          textDirection: pw.TextDirection.rtl,
          pageFormat: PdfPageFormat.a4,
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
        build: (pw.Context context) {
          return [
            pw.TableHelper.fromTextArray(
              headers: columns.map((column) => column).toList(),
              headerStyle: pw.TextStyle(
                  font: ttf, fontSize: 8, fontWeight: pw.FontWeight.bold),
              headerDecoration:
                  pw.BoxDecoration(color: PdfColor.fromHex('ffd59a4c')),
              border: pw.TableBorder.all(color: PdfColors.grey),
              oddRowDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey200),
              data: data,
              cellStyle: pw.TextStyle(fontSize: 8, font: ttf),
            )
          ];
        },
      ),
    );

    return pdf;
  }
}
