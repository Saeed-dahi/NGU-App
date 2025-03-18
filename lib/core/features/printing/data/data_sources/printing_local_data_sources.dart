import 'package:ngu_app/core/features/printing/data/database/printing_data_base.dart';
import 'package:ngu_app/core/features/printing/data/models/printer_model.dart';

abstract class PrintingDataSource {
  Future<List<PrinterModel>> getPrinters();
  Future<PrinterModel> getPrinter(String printerType);
  Future<PrinterModel> addNewPrinter(PrinterModel printer);
  Future<PrinterModel> updatePrinter(String printerType);
}

class PrintingDataSourceImpl implements PrintingDataSource {
  final PrintingDataBase printingDataBase;

  PrintingDataSourceImpl({required this.printingDataBase});

  @override
  Future<PrinterModel> addNewPrinter(PrinterModel printer) async {
    final db = await printingDataBase.database;
    await db.insert('printing_table', printer.toJson());

    return printer;
  }

  @override
  Future<PrinterModel> getPrinter(String printerType) async {
    final db = await printingDataBase.database;
    final result = await db.query('printing_table',
        where: 'printer_type = ?', whereArgs: [printerType]);

    PrinterModel printer = PrinterModel.fromJson(result.first);

    return printer;
  }

  @override
  Future<List<PrinterModel>> getPrinters() async {
    final db = await printingDataBase.database;
    final result = await db.query('printing_table');

    List<PrinterModel> printers =
        result.map((item) => PrinterModel.fromJson(item)).toList();

    return printers;
  }

  @override
  Future<PrinterModel> updatePrinter(String printerType) async {
    final db = await printingDataBase.database;
    await db.update('printing_table', {'printer_type': printerType},
        where: 'printer_type = ?', whereArgs: [printerType]);

    return getPrinter(printerType);
  }
}
