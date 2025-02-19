import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/inventory/invoices/data/models/params/preview_invoice_item_model_params.dart';

class PreviewInvoiceItemEntityParams extends Equatable {
  final String query;
  final int? productUnitId;
  final int? accountId;
  final int? invoiceId;
  final double? quantity;
  final double? price;

  const PreviewInvoiceItemEntityParams({
    required this.query,
    this.productUnitId,
    this.accountId,
    this.invoiceId,
    this.quantity,
    this.price,
  });

  PreviewInvoiceItemModelParams toModel() {
    return PreviewInvoiceItemModelParams(
        query: query,
        productUnitId: productUnitId,
        accountId: accountId,
        invoiceId: invoiceId,
        price: price,
        quantity: quantity);
  }

  @override
  List<Object?> get props => [query, productUnitId, accountId];
}
