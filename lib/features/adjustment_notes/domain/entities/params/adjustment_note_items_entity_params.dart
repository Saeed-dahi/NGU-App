import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/adjustment_notes/data/models/params/adjustment_note_items_model_params.dart';

class AdjustmentNoteItemsEntityParams extends Equatable {
  final String? productUnitId;
  final String? description;
  final double? quantity;
  final double? price;
  final double? taxAmount;
  final double? discountAmount;

  const AdjustmentNoteItemsEntityParams(
      {this.productUnitId,
      this.description,
      this.quantity,
      this.price,
      this.taxAmount,
      this.discountAmount});

  @override
  List<Object?> get props =>
      [productUnitId, description, quantity, price, taxAmount, discountAmount];

  AdjustmentNoteItemsModelParams toModel() {
    return AdjustmentNoteItemsModelParams(
        description: description,
        discountAmount: discountAmount,
        price: price,
        productUnitId: productUnitId,
        quantity: quantity,
        taxAmount: taxAmount);
  }
}
