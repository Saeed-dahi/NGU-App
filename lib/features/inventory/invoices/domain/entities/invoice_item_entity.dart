import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/inventory/invoices/data/models/invoice_item_model.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_product_unit_entity.dart';

class InvoiceItemEntity extends Equatable {
  final int id;
  final int invoiceId;
  final InvoiceProductUnitEntity productUnit;
  final String? description;
  final double quantity;
  final double price;
  final double taxAmount;
  final double discountAmount;
  final double total;

  const InvoiceItemEntity(
      {required this.id,
      required this.invoiceId,
      required this.productUnit,
      required this.description,
      required this.quantity,
      required this.price,
      required this.taxAmount,
      required this.discountAmount,
      required this.total});

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
