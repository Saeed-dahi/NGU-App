import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/adjustment_notes/data/models/adjustemnt_note_item_model.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_product_unit_entity.dart';

class AdjustmentNoteItemEntity extends Equatable {
  final int? id;
  final int? invoiceId;
  final AdjustmentNoteProductUnitEntity? productUnit;
  final String? description;
  final double? quantity;
  final double? price;
  final double? taxAmount;
  final double? discountAmount;
  final double? total;

  const AdjustmentNoteItemEntity(
      {this.id,
      this.invoiceId,
      this.productUnit,
      this.description,
      this.quantity,
      this.price,
      this.taxAmount,
      this.discountAmount,
      this.total});

  AdjustmentNoteItemEntity copyWith(
      {int? id,
      int? invoiceId,
      AdjustmentNoteProductUnitEntity? productUnit,
      String? description,
      double? quantity,
      double? price,
      double? taxAmount,
      double? discountAmount,
      double? total}) {
    return AdjustmentNoteItemEntity(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      productUnit: productUnit ?? this.productUnit,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      taxAmount: taxAmount ?? this.taxAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [
        id,
        invoiceId,
        productUnit,
        description,
        quantity,
        price,
        taxAmount,
        discountAmount,
      ];

  AdjustmentNoteItemModel toModel() {
    return AdjustmentNoteItemModel(
        id: id,
        invoiceId: invoiceId,
        productUnit: productUnit,
        description: description,
        quantity: quantity,
        price: price,
        taxAmount: taxAmount,
        discountAmount: discountAmount,
        total: total);
  }
}
