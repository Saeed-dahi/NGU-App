import 'package:ngu_app/features/inventory/invoices/domain/entities/params/preview_invoice_item_entity_params.dart';

class PreviewInvoiceItemModelParams extends PreviewInvoiceItemEntityParams {
  const PreviewInvoiceItemModelParams(
      {required super.query,
      super.accountId,
      super.productUnitId,
      super.invoiceId,
      super.price,
      super.quantity});

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      if (productUnitId != null) 'product_unit_id': productUnitId.toString(),
      if (accountId != null) 'account_id': accountId.toString(),
      if (invoiceId != null) 'invoice_id': invoiceId.toString(),
      if (price != null) 'price': price.toString(),
      if (quantity != null) 'quantity': quantity.toString(),
    };
  }
}
