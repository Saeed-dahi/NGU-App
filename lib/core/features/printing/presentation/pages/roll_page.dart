import 'package:ngu_app/app/app_config/constant.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class RollPage {
  static buildCustomRollPage(
      {required List columns,
      required data,
      required Font ttf,
      Map<int, TableColumnWidth>? columnWidths,
      Widget? customPageHeader}) async {
    final pdf = Document();
    pdf.addPage(
      Page(
        margin: const EdgeInsets.only(right: 30, bottom: 10),
        theme: ThemeData(textAlign: TextAlign.center),
        pageFormat: PdfPageFormat.roll80,
        textDirection: TextDirection.rtl,
        build: (Context context) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customPageHeader ?? SizedBox(),
                TableHelper.fromTextArray(
                  headers: columns.map((column) => column).toList(),
                  headerStyle: TextStyle(
                      font: ttf,
                      fontSize: Dimensions.printingSecondaryTextSize,
                      fontWeight: FontWeight.bold),
                  headerDecoration:
                      BoxDecoration(color: PdfColor.fromHex('#7F7F7F')),
                  border: TableBorder.all(color: PdfColors.black),
                  data: data,
                  columnWidths: columnWidths,
                  cellStyle: TextStyle(
                      fontSize: Dimensions.printingSecondaryTextSize,
                      font: ttf),
                )
              ]);
        },
      ),
    );

    return pdf;
  }
}
