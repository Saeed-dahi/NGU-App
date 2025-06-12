import 'package:equatable/equatable.dart';

class AdjustmentNoteProductUnitEntity extends Equatable {
  final int? id;
  final AdjustmentNoteProductEntity? product;
  final AdjustmentNoteUnitEntity? unit;

  const AdjustmentNoteProductUnitEntity({this.id, this.product, this.unit});

  AdjustmentNoteProductUnitEntity copyWith(
      {int? id, AdjustmentNoteProductEntity? product, AdjustmentNoteUnitEntity? unit}) {
    return AdjustmentNoteProductUnitEntity(
      id: id ?? this.id,
      product: product ?? this.product,
      unit: unit ?? this.unit,
    );
  }

  @override
  List<Object?> get props => [id, product, unit];
}

class AdjustmentNoteProductEntity extends Equatable {
  final int? id;
  final String? arName;
  final String? enName;
  final String? code;

  const AdjustmentNoteProductEntity({this.id, this.arName, this.enName, this.code});

  AdjustmentNoteProductEntity copyWith(
      {int? id, String? arName, String? enName, String? code}) {
    return AdjustmentNoteProductEntity(
      id: id ?? this.id,
      arName: arName ?? this.arName,
      enName: enName ?? this.enName,
      code: code ?? this.code,
    );
  }

  @override
  List<Object?> get props => [id, arName, enName, code];
}

class AdjustmentNoteUnitEntity extends Equatable {
  final int? id;
  final String? arName;
  final String? enName;

  const AdjustmentNoteUnitEntity({
    this.id,
    this.arName,
    this.enName,
  });

  AdjustmentNoteUnitEntity copyWith({int? id, String? arName, String? enName}) {
    return AdjustmentNoteUnitEntity(
      id: id ?? this.id,
      arName: arName ?? this.arName,
      enName: enName ?? this.enName,
    );
  }

  @override
  List<Object?> get props => [id, arName, enName];
}
