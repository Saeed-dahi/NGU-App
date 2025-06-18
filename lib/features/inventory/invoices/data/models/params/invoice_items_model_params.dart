import 'package:ngu_app/features/inventory/invoices/domain/entities/params/invoice_items_entity_params.dart';

class InvoiceItemsModelParams extends InvoiceItemsEntityParams {
  const InvoiceItemsModelParams(
      {super.productUnitId,
      super.description,
      super.quantity,
      super.price,
      super.taxAmount,
      super.discountAmount});

  Map<String, dynamic> toJson() {
    return {
      'product_unit_id': productUnitId,
      'description': description,
      'quantity': quantity,
      'price': price,
      if (discountAmount != null) 'discount_amount': discountAmount
    };
  }
}
