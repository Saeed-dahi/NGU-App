import 'package:equatable/equatable.dart';
import 'package:ngu_app/core/features/printing/data/models/printer_model.dart';
import 'package:printing/printing.dart';

class PrinterEntity extends Equatable {
  final int? id;
  final String url;

  final String name;

  final String printerType;

  const PrinterEntity(
      {this.id,
      required this.url,
      required this.name,
      required this.printerType});

  Printer toPrinter() {
    return Printer(url: url, name: name);
  }

  PrinterModel toPrinterModel() {
    return PrinterModel(id: id, url: url, name: name, printerType: printerType);
  }

  @override
  List<Object?> get props => [id, url, name, printerType];
}
