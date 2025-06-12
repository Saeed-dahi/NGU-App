import 'package:ngu_app/features/adjustment_notes/domain/entities/params/preview_adjustment_note_item_entity_params.dart';

class PreviewAdjustmentNoteItemModelParams
    extends PreviewAdjustmentNoteItemEntityParams {
  const PreviewAdjustmentNoteItemModelParams(
      {required super.query,
      super.accountId,
      super.productUnitId,
      super.invoiceId,
      super.price,
      super.quantity,
      super.changeUnit});

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      if (productUnitId != null) 'product_unit_id': productUnitId.toString(),
      if (accountId != null) 'account_id': accountId.toString(),
      if (invoiceId != null) 'invoice_id': invoiceId.toString(),
      if (price != null) 'price': price.toString(),
      if (quantity != null) 'quantity': quantity.toString(),
      if (changeUnit != null) 'change_unit': changeUnit.toString(),
    };
  }
}
