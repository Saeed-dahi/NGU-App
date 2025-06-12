import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/adjustment_notes/data/models/params/preview_adjustment_note_item_model_params.dart';

class PreviewAdjustmentNoteItemEntityParams extends Equatable {
  final String query;
  final int? productUnitId;
  final int? accountId;
  final int? invoiceId;
  final double? quantity;
  final double? price;
  final bool? changeUnit;

  const PreviewAdjustmentNoteItemEntityParams({
    required this.query,
    this.productUnitId,
    this.accountId,
    this.invoiceId,
    this.quantity,
    this.price,
    this.changeUnit,
  });

  PreviewAdjustmentNoteItemModelParams toModel() {
    return PreviewAdjustmentNoteItemModelParams(
        query: query,
        productUnitId: productUnitId,
        accountId: accountId,
        invoiceId: invoiceId,
        price: price,
        quantity: quantity,
        changeUnit: changeUnit);
  }

  @override
  List<Object?> get props =>
      [query, productUnitId, accountId, invoiceId, quantity, price, changeUnit];
}
