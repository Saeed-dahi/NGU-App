import 'package:ngu_app/features/inventory/invoices/domain/entities/preview_invoice_item_entity.dart';

class PreviewInvoiceItemModel extends PreviewInvoiceItemEntity {
  const PreviewInvoiceItemModel(
      {required super.id,
      required super.arName,
      required super.enName,
      required super.code,
      required super.productUnit});

  factory PreviewInvoiceItemModel.toJson(Map<String, dynamic> json) {
    return PreviewInvoiceItemModel(
        id: json['id'],
        arName: json['ar_name'],
        enName: json['en_name'],
        code: json['code'],
        productUnit: PreviewProductUnitModel.toJson(json['unit']));
  }
}

class PreviewProductUnitModel extends PreviewProductUnitEntity {
  const PreviewProductUnitModel(
      {required super.id,
      required super.arName,
      required super.enName,
      required super.price});

  factory PreviewProductUnitModel.toJson(Map<String, dynamic> json) {
    return PreviewProductUnitModel(
        id: json['id'],
        arName: json['ar_name'],
        enName: json['en_name'],
        price: double.parse(json['price'].toString()));
  }
}
