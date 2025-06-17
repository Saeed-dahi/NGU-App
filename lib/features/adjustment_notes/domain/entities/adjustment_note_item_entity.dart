import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/adjustment_notes/data/models/adjustment_note_item_model.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_product_unit_entity.dart';

class AdjustmentNoteItemEntity extends Equatable {
  final int? id;
  final int? adjustmentNoteId;
  final AdjustmentNoteProductUnitEntity? productUnit;
  final String? description;
  final double? quantity;
  final double? price;
  final double? taxAmount;

  final double? total;

  const AdjustmentNoteItemEntity(
      {this.id,
      this.adjustmentNoteId,
      this.productUnit,
      this.description,
      this.quantity,
      this.price,
      this.taxAmount,
      this.total});

  AdjustmentNoteItemEntity copyWith(
      {int? id,
      int? adjustmentNoteId,
      AdjustmentNoteProductUnitEntity? productUnit,
      String? description,
      double? quantity,
      double? price,
      double? taxAmount,
      double? discountAmount,
      double? total}) {
    return AdjustmentNoteItemEntity(
      id: id ?? this.id,
      adjustmentNoteId: adjustmentNoteId ?? this.adjustmentNoteId,
      productUnit: productUnit ?? this.productUnit,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      taxAmount: taxAmount ?? this.taxAmount,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [
        id,
        adjustmentNoteId,
        productUnit,
        description,
        quantity,
        price,
        taxAmount,
      ];

  AdjustmentNoteItemModel toModel() {
    return AdjustmentNoteItemModel(
        id: id,
        adjustmentNoteId: adjustmentNoteId,
        productUnit: productUnit,
        description: description,
        quantity: quantity,
        price: price,
        taxAmount: taxAmount,
        total: total);
  }
}
