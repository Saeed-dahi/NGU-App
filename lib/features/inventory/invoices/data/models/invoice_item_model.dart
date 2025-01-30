import 'package:ngu_app/features/inventory/invoices/data/models/invoice_product_unit_model.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_item_entity.dart';

class InvoiceItemModel extends InvoiceItemEntity {
  const InvoiceItemModel(
      {required super.id,
      required super.invoiceId,
      required super.productUnit,
      required super.description,
      required super.quantity,
      required super.price,
      required super.taxAmount,
      required super.discountAmount,
      required super.total});

  factory InvoiceItemModel.fromJson(Map<String, dynamic> json) {
    return InvoiceItemModel(
      id: json['id'],
      invoiceId: json['invoice_id'],
      productUnit: InvoiceProductUnitModel.fromJson(json['product_unit']),
      description: json['description'] ?? '',
      quantity: double.parse(json['quantity'].toString()),
      price: double.parse(json['price'].toString()),
      taxAmount: double.parse(json['tax_amount'].toString()),
      discountAmount: double.parse(json['discount_amount'].toString()),
      total: double.parse(json['total'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_unit_id': productUnit,
      if (description != null) 'description': description,
      'quantity': quantity,
      'price': price,
      'tax_amount': taxAmount,
      'discount_amount': discountAmount
    };
  }
}
