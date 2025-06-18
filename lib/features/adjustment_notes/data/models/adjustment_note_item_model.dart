import 'package:ngu_app/features/adjustment_notes/data/models/adjustment_note_product_unit_model.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_item_entity.dart';

class AdjustmentNoteItemModel extends AdjustmentNoteItemEntity {
  const AdjustmentNoteItemModel(
      {super.id,
      super.adjustmentNoteId,
      super.productUnit,
      super.description,
      super.quantity,
      super.price,
      super.taxAmount,
      super.total});

  factory AdjustmentNoteItemModel.fromJson(Map<String, dynamic> json) {
    return AdjustmentNoteItemModel(
      id: json['id'],
      adjustmentNoteId: json['invoice_id'],
      productUnit:
          AdjustmentNoteProductUnitModel.fromJson(json['product_unit']),
      description: json['description'] ?? '',
      quantity: double.parse(json['quantity'].toString()),
      price: double.parse(json['price'].toString()),
      taxAmount: double.parse(json['tax_amount'].toString()),
      total: double.parse(json['total'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_unit_id': productUnit,
      if (description != null) 'description': description,
      'quantity': quantity,
      'price': price,
    };
  }
}
