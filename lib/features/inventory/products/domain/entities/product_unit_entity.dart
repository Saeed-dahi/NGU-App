import 'package:equatable/equatable.dart';

class ProductUnitEntity extends Equatable {
  final int? id;
  final int productId;
  final int unitId;
  final String? arName;
  final String? enName;
  final double? conversionFactor;
  final double? exportPrice;
  final double? importPrice;
  final double? wholeSalePrice;
  final double? endPrice;
  final double? quantity;
  final ProductUnitEntity? subUnit;

  const ProductUnitEntity(
      {this.id,
      required this.productId,
      required this.unitId,
      this.arName,
      this.enName,
      this.conversionFactor,
      this.exportPrice,
      this.importPrice,
      this.wholeSalePrice,
      this.endPrice,
      this.quantity,
      this.subUnit});

  @override
  List<Object?> get props => [
        id,
        productId,
        unitId,
        arName,
        enName,
        conversionFactor,
        exportPrice,
        importPrice,
        wholeSalePrice,
        endPrice,
        quantity
      ];
}
