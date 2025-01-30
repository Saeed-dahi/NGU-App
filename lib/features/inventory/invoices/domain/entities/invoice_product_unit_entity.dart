import 'package:equatable/equatable.dart';

class InvoiceProductUnitEntity extends Equatable {
  final int id;
  final InvoiceProductEntity product;
  final InvoiceUnitEntity unit;

  const InvoiceProductUnitEntity(
      {required this.id, required this.product, required this.unit});
  @override
  List<Object?> get props => [id, product, unit];
}

class InvoiceProductEntity extends Equatable {
  final int id;
  final String arName;
  final String enName;
  final String code;

  const InvoiceProductEntity(
      {required this.id,
      required this.arName,
      required this.enName,
      required this.code});

  @override
  List<Object?> get props => [id, arName, enName, code];
}

class InvoiceUnitEntity extends Equatable {
  final int id;
  final String arName;
  final String enName;

  const InvoiceUnitEntity({
    required this.id,
    required this.arName,
    required this.enName,
  });

  @override
  List<Object?> get props => [id, arName, enName];
}
