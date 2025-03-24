import 'package:ngu_app/app/app_config/constant.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class TaxInvoicePage {
  static buildCustomTaxInvoicePage(
      {required List columns,
      required data,
      required Font ttf,
      required Widget customContent}) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        pageTheme: const PageTheme(
          textDirection: TextDirection.rtl,
          margin: EdgeInsets.only(left: 10),
        ),
        build: (Context context) {
          List<Widget> content = [];
          content.add(customContent);
          content.add(
            TableHelper.fromTextArray(
                headers: [],
                border: TableBorder.all(width: 0, color: PdfColors.white),
                data: data,
                cellStyle: TextStyle(
                    fontSize: Dimensions.printingSecondaryTextSize, font: ttf),
                columnWidths: {1: const FixedColumnWidth(120)}),
          );

          return content;
        },
      ),
    );

    return pdf;
  }
}
