import 'package:ngu_app/features/adjustment_notes/domain/entities/params/adjustment_note_items_entity_params.dart';

class AdjustmentNoteItemsModelParams extends AdjustmentNoteItemsEntityParams {
  const AdjustmentNoteItemsModelParams(
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
      if (taxAmount != null) 'tax_account': taxAmount,
      if (discountAmount != null) 'discount_amount': discountAmount
    };
  }
}
