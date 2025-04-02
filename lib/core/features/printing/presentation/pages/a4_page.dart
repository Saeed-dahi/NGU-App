import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart';

class A4Page {
  static buildCustomA4Page(
      {required List columns,
      required data,
      required Font ttf,
      Widget? customContent}) async {
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image(
                headerImage,
              ),
              customContent ?? SizedBox(),
            ],
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
              headers: columns.map((column) => column.toString().tr).toList(),
              headerStyle: TextStyle(
                  font: ttf,
                  fontSize: Dimensions.printingSecondaryTextSize,
                  fontWeight: FontWeight.bold),
              headerDecoration:
                  BoxDecoration(color: PdfColor.fromHex('ffd59a4c')),
              border: TableBorder.all(color: PdfColors.grey),
              oddRowDecoration: const BoxDecoration(color: PdfColors.grey200),
              data: data,
              cellStyle: TextStyle(
                  fontSize: Dimensions.printingSecondaryTextSize, font: ttf),
            )
          ];
        },
      ),
    );

    return pdf;
  }
}
