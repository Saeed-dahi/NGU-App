import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_item_entity.dart';

class InvoiceItemModel extends InvoiceItemEntity {
  const InvoiceItemModel(
      {required super.id,
      required super.invoiceId,
      required super.productUnitId,
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
        productUnitId: json['product_unit_id'],
        description: json['description'] ?? '',
        quantity: json['quantity'],
        price: json['price'],
        taxAmount: json['tax_amount'],
        discountAmount: json['discount_amount'],
        total: json['total']);
  }

  Map<String, dynamic> toJson() {
    return {
      'product_unit_id': productUnitId,
      if (description != null) 'description': description,
      'quantity': quantity,
      'price': price,
      'tax_amount': taxAmount,
      'discount_amount': discountAmount
    };
  }
}
