import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_product_unit_entity.dart';

class InvoiceProductUnitModel extends InvoiceProductUnitEntity {
  const InvoiceProductUnitModel(
      {required super.id, required super.product, required super.unit});

  factory InvoiceProductUnitModel.fromJson(Map<String, dynamic> json) {
    return InvoiceProductUnitModel(
        id: json['id'],
        product: InvoiceProductModel.fromJson(json['product']),
        unit: InvoiceUnitModel.fromJson(json['product']));
  }
}

class InvoiceProductModel extends InvoiceProductEntity {
  const InvoiceProductModel(
      {required super.id,
      required super.code,
      required super.arName,
      required super.enName});

  factory InvoiceProductModel.fromJson(Map<String, dynamic> json) {
    return InvoiceProductModel(
        id: json['id'],
        code: json['code'],
        arName: json['ar_name'],
        enName: json['en_name']);
  }
}

class InvoiceUnitModel extends InvoiceUnitEntity {
  const InvoiceUnitModel(
      {required super.id, required super.arName, required super.enName});

  factory InvoiceUnitModel.fromJson(Map<String, dynamic> json) {
    return InvoiceUnitModel(
        id: json['id'], arName: json['ar_name'], enName: json['en_name']);
  }
}
