import 'package:ngu_app/app/app_config/constant.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class TaxInvoicePage {
  static buildCustomTaxInvoicePage(
      {required List columns,
      required data,
      required Font ttf,
      required Widget customContent,
      required Widget footer,
      Map<int, TableColumnWidth>? columnWidths}) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        pageTheme: const PageTheme(
          textDirection: TextDirection.rtl,
          margin: EdgeInsets.only(left: 16),
        ),
        footer: (context) {
          return footer;
        },
        header: (context) {
          return Container(
              margin: const EdgeInsets.only(
                  bottom: PdfPageFormat.cm * 0.5, top: PdfPageFormat.cm * 4.5),
              child: customContent);
        },
        build: (Context context) {
          List<Widget> content = [];
          content.add(Container(
            child: TableHelper.fromTextArray(
                headers: [],
                border: TableBorder.all(width: 0, color: PdfColors.white),
                data: data,
                cellStyle: TextStyle(
                    fontSize: Dimensions.printingSecondaryTextSize, font: ttf),
                columnWidths: columnWidths),
          ));

          return content;
        },
      ),
    );

    return pdf;
  }
}
