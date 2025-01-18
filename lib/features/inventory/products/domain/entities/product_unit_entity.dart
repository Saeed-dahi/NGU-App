import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/inventory/products/data/models/product_unit_model.dart';

class ProductUnitEntity extends Equatable {
  final int? id;
  final int? productId;
  final int? unitId;
  final String? name;
  final double? conversionFactor;
  final double? exportPrice;
  final double? importPrice;
  final double? wholeSalePrice;
  final double? endPrice;
  final double? quantity;
  final ProductUnitEntity? subUnit;

  const ProductUnitEntity(
      {this.id,
      this.productId,
      this.unitId,
      this.name,
      this.conversionFactor,
      this.exportPrice,
      this.importPrice,
      this.wholeSalePrice,
      this.endPrice,
      this.quantity,
      this.subUnit});

  ProductUnitModel toModel() {
    return ProductUnitModel(
      id: id,
      productId: productId,
      unitId: unitId,
      endPrice: endPrice,
      exportPrice: exportPrice,
      importPrice: importPrice,
      conversionFactor: conversionFactor,
      wholeSalePrice: wholeSalePrice,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        unitId,
        name,
        conversionFactor,
        exportPrice,
        importPrice,
        wholeSalePrice,
        endPrice,
        quantity
      ];
}
