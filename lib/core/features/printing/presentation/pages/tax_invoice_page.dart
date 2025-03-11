import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class TaxInvoicePage {
  static buildCustomTaxInvoicePage(
      {required List columns, required data, required Font ttf}) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        pageTheme: const PageTheme(
          textDirection: TextDirection.rtl,
          margin: EdgeInsets.only(left: 10),
        ),
        build: (Context context) {
          List<Widget> content = [];

          content.add(Container(
            margin: const EdgeInsets.only(
                left: PdfPageFormat.cm * 3, right: PdfPageFormat.cm * 2),
            child: Column(
              children: [
                SizedBox(height: PdfPageFormat.cm * 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '5247',
                      style: TextStyle(fontSize: 9, font: ttf),
                    ),
                    Text(
                      'السويدان لتجارة المواد الغذائية',
                      style: TextStyle(fontSize: 9, font: ttf),
                    ),
                  ],
                ),
                SizedBox(height: PdfPageFormat.cm * 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'أبو ظبي',
                      style: TextStyle(fontSize: 10, font: ttf),
                    ),
                  ],
                ),
                SizedBox(height: PdfPageFormat.cm * 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '10/03/2025',
                      style: TextStyle(fontSize: 10, font: ttf),
                    ),
                    Text(
                      '123456789987654321',
                      style: TextStyle(fontSize: 10, font: ttf),
                    ),
                  ],
                ),
                SizedBox(height: PdfPageFormat.cm * 0.5),
              ],
            ),
          ));

          content.add(
            TableHelper.fromTextArray(
                headers: [],
                border: TableBorder.all(width: 0, color: PdfColors.white),
                data: data,
                cellStyle: TextStyle(fontSize: 8, font: ttf),
                columnWidths: {1: const FixedColumnWidth(120)}),
          );

          return content;
        },
      ),
    );

    return pdf;
  }
}
