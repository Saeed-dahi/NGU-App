import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart';

class A4Page {
  static buildCustomA4Page(
      {required List columns, required data, required Font ttf}) async {
    final headerImage = MemoryImage(
      (await rootBundle.load('assets/images/header.jpeg')).buffer.asUint8List(),
    );
    final backgroundImage = MemoryImage(
      (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List(),
    );
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        header: (context) {
          return Image(
            headerImage,
          );
        },
        pageTheme: PageTheme(
          textDirection: TextDirection.rtl,
          pageFormat: PdfPageFormat.a4,
          buildBackground: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Opacity(
                    opacity: 0.3,
                    child: Image(
                      backgroundImage,
                    ),
                  )
                ])
              ],
            );
          },
        ),
        build: (Context context) {
          return [
            TableHelper.fromTextArray(
              headers: columns.map((column) => column).toList(),
              headerStyle: TextStyle(
                  font: ttf, fontSize: 8, fontWeight: FontWeight.bold),
              headerDecoration:
                  BoxDecoration(color: PdfColor.fromHex('ffd59a4c')),
              border: TableBorder.all(color: PdfColors.grey),
              oddRowDecoration: const BoxDecoration(color: PdfColors.grey200),
              data: data,
              cellStyle: TextStyle(fontSize: 8, font: ttf),
            )
          ];
        },
      ),
    );

    return pdf;
  }
}
