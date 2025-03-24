import 'package:ngu_app/core/features/printing/domain/entities/printer_entity.dart';

class PrinterModel extends PrinterEntity {
  const PrinterModel(
      {super.id,
      required super.url,
      required super.name,
      required super.printerType});

  factory PrinterModel.fromJson(Map<String, dynamic> json) {
    return PrinterModel(
        id: json['id'],
        url: json['url'],
        name: json['name'],
        printerType: json['printer_type']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'printer_type': printerType,
    };
  }
}
