import 'package:ngu_app/features/adjustment_notes/data/models/adjustemnt_note_product_unit_model.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_item_entity.dart';

class AdjustmentNoteItemModel extends AdjustmentNoteItemEntity {
  const AdjustmentNoteItemModel(
      {super.id,
      super.invoiceId,
      super.productUnit,
      super.description,
      super.quantity,
      super.price,
      super.taxAmount,
      super.discountAmount,
      super.total});

  factory AdjustmentNoteItemModel.fromJson(Map<String, dynamic> json) {
    return AdjustmentNoteItemModel(
      id: json['id'],
      invoiceId: json['invoice_id'],
      productUnit:
          AdjustmentNoteProductUnitModel.fromJson(json['product_unit']),
      description: json['description'] ?? '',
      quantity: double.parse(json['quantity'].toString()),
      price: double.parse(json['price'].toString()),
      taxAmount: double.parse(json['tax_amount'].toString()),
      discountAmount: double.parse(json['discount_amount'].toString()),
      total: double.parse(json['total'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_unit_id': productUnit,
      if (description != null) 'description': description,
      'quantity': quantity,
      'price': price,
      'tax_amount': taxAmount,
      'discount_amount': discountAmount
    };
  }
}
