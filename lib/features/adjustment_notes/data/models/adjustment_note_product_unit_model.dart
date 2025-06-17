import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_product_unit_entity.dart';

class AdjustmentNoteProductUnitModel extends AdjustmentNoteProductUnitEntity {
  const AdjustmentNoteProductUnitModel(
      {required super.id, required super.product, required super.unit});

  factory AdjustmentNoteProductUnitModel.fromJson(Map<String, dynamic> json) {
    return AdjustmentNoteProductUnitModel(
        id: json['id'],
        product: AdjustmentNoteProductModel.fromJson(json['product']),
        unit: AdjustmentNoteUnitModel.fromJson(json['unit']));
  }
}

class AdjustmentNoteProductModel extends AdjustmentNoteProductEntity {
  const AdjustmentNoteProductModel(
      {required super.id,
      required super.code,
      required super.arName,
      required super.enName});

  factory AdjustmentNoteProductModel.fromJson(Map<String, dynamic> json) {
    return AdjustmentNoteProductModel(
        id: json['id'],
        code: json['code'],
        arName: json['ar_name'],
        enName: json['en_name']);
  }
}

class AdjustmentNoteUnitModel extends AdjustmentNoteUnitEntity {
  const AdjustmentNoteUnitModel(
      {required super.id, required super.arName, required super.enName});

  factory AdjustmentNoteUnitModel.fromJson(Map<String, dynamic> json) {
    return AdjustmentNoteUnitModel(
        id: json['id'], arName: json['ar_name'], enName: json['en_name']);
  }
}
