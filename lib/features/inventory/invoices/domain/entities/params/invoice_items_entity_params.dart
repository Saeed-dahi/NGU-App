import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/inventory/invoices/data/models/params/invoice_items_model_params.dart';

class InvoiceItemsEntityParams extends Equatable {
  final String? productUnitId;
  final String? description;
  final double? quantity;
  final double? price;
  final double? taxAmount;
  final double? discountAmount;

  const InvoiceItemsEntityParams(
      {this.productUnitId,
      this.description,
      this.quantity,
      this.price,
      this.taxAmount,
      this.discountAmount});

  @override
  List<Object?> get props =>
      [productUnitId, description, quantity, price, taxAmount, discountAmount];

  InvoiceItemsModelParams toModel() {
    return InvoiceItemsModelParams(
        description: description,
        discountAmount: discountAmount,
        price: price,
        productUnitId: productUnitId,
        quantity: quantity,
        taxAmount: taxAmount);
  }
}
