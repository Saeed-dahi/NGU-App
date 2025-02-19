import 'package:equatable/equatable.dart';

class PreviewInvoiceItemEntity extends Equatable {
  final int id;
  final String arName;
  final String enName;
  final String code;
  final PreviewProductUnitEntity productUnit;

  const PreviewInvoiceItemEntity(
      {required this.id,
      required this.arName,
      required this.enName,
      required this.code,
      required this.productUnit});

  @override
  List<Object?> get props => [id, arName, enName, code, productUnit];
}

class PreviewProductUnitEntity extends Equatable {
  final int id;
  final String arName;
  final String enName;
  final int unitId;
  final double price;

  const PreviewProductUnitEntity(
      {required this.id,
      required this.arName,
      required this.enName,
      required this.unitId,
      required this.price});

  @override
  List<Object?> get props => [id, arName, enName, unitId, price];
}
