import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/inventory/invoices/data/models/invoice_item_model.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_product_unit_entity.dart';

class InvoiceItemEntity extends Equatable {
  final int? id;
  final int? invoiceId;
  final InvoiceProductUnitEntity? productUnit;
  final String? description;
  final double? quantity;
  final double? price;
  final double? taxAmount;
  final double? discountAmount;
  final double? total;

  const InvoiceItemEntity(
      {this.id,
      this.invoiceId,
      this.productUnit,
      this.description,
      this.quantity,
      this.price,
      this.taxAmount,
      this.discountAmount,
      this.total});

  InvoiceItemEntity copyWith(
      {int? id,
      int? invoiceId,
      InvoiceProductUnitEntity? productUnit,
      String? description,
      double? quantity,
      double? price,
      double? taxAmount,
      double? discountAmount,
      double? total}) {
    return InvoiceItemEntity(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      productUnit: productUnit ?? this.productUnit,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      taxAmount: taxAmount ?? this.taxAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [
        id,
        invoiceId,
        productUnit,
        description,
        quantity,
        price,
        taxAmount,
        discountAmount,
      ];

  InvoiceItemModel toModel() {
    return InvoiceItemModel(
        id: id,
        invoiceId: invoiceId,
        productUnit: productUnit,
        description: description,
        quantity: quantity,
        price: price,
        taxAmount: taxAmount,
        discountAmount: discountAmount,
        total: total);
  }
}
