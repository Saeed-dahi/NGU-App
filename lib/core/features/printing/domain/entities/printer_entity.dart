import 'package:equatable/equatable.dart';
import 'package:ngu_app/core/features/printing/data/models/printer_model.dart';
import 'package:printing/printing.dart';

class PrinterEntity extends Equatable {
  final String url;

  final String name;

  final String printerType;

  const PrinterEntity(
      {required this.url, required this.name, required this.printerType});

  Printer toPrinter() {
    return Printer(url: url, name: name);
  }

  PrinterModel toPrinterModel() {
    return PrinterModel(url: url, name: name, printerType: printerType);
  }

  @override
  List<Object?> get props => [url, name, printerType];
}
