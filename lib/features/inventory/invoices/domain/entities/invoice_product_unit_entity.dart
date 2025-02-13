import 'package:equatable/equatable.dart';

class InvoiceProductUnitEntity extends Equatable {
  final int? id;
  final InvoiceProductEntity? product;
  final InvoiceUnitEntity? unit;

  const InvoiceProductUnitEntity({this.id, this.product, this.unit});

  InvoiceProductUnitEntity copyWith(
      {int? id, InvoiceProductEntity? product, InvoiceUnitEntity? unit}) {
    return InvoiceProductUnitEntity(
      id: id ?? this.id,
      product: product ?? this.product,
      unit: unit ?? this.unit,
    );
  }

  @override
  List<Object?> get props => [id, product, unit];
}

class InvoiceProductEntity extends Equatable {
  final int? id;
  final String? arName;
  final String? enName;
  final String? code;

  const InvoiceProductEntity({this.id, this.arName, this.enName, this.code});

  InvoiceProductEntity copyWith(
      {int? id, String? arName, String? enName, String? code}) {
    return InvoiceProductEntity(
      id: id ?? this.id,
      arName: arName ?? this.arName,
      enName: enName ?? this.enName,
      code: code ?? this.code,
    );
  }

  @override
  List<Object?> get props => [id, arName, enName, code];
}

class InvoiceUnitEntity extends Equatable {
  final int? id;
  final String? arName;
  final String? enName;

  const InvoiceUnitEntity({
    this.id,
    this.arName,
    this.enName,
  });

  InvoiceUnitEntity copyWith({int? id, String? arName, String? enName}) {
    return InvoiceUnitEntity(
      id: id ?? this.id,
      arName: arName ?? this.arName,
      enName: enName ?? this.enName,
    );
  }

  @override
  List<Object?> get props => [id, arName, enName];
}
