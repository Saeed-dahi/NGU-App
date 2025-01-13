import 'package:ngu_app/features/inventory/products/domain/entities/product_unit_entity.dart';

class ProductUnitModel extends ProductUnitEntity {
  const ProductUnitModel({
    super.id,
    required super.productId,
    required super.unitId,
    super.name,
    super.conversionFactor,
    super.endPrice,
    super.exportPrice,
    super.importPrice,
    super.wholeSalePrice,
    super.quantity,
    super.subUnit,
  });

  factory ProductUnitModel.fromJson(Map<String, dynamic> json) {
    return ProductUnitModel(
      id: json['id'],
      productId: json['product_id'],
      unitId: json['unit_id'],
      name: json['name'] ?? '',
      conversionFactor: double.parse(json['conversion_factor'] ?? '0.0'),
      endPrice: double.tryParse(json['end_price']) ?? 0.0,
      exportPrice: double.tryParse(json['export_price']) ?? 0.0,
      importPrice: double.tryParse(json['import_price']) ?? 0.0,
      wholeSalePrice: double.tryParse(json['wholesale_price']) ?? 0.0,
      quantity: double.tryParse(json['quantity']) ?? 0.0,
      subUnit: json['sub_unit'] != null
          ? ProductUnitModel.fromJson(json['sub_unit'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id.toString(),
      if (productId != null) 'product_id': productId.toString(),
      if (unitId != null) 'unit_id': unitId.toString(),
      if (conversionFactor != null)
        if (conversionFactor != null)
          'conversion_factor': conversionFactor.toString(),
      if (endPrice != null) 'end_price': endPrice.toString(),
      if (exportPrice != null) 'export_price': exportPrice.toString(),
      if (importPrice != null) 'import_price': importPrice.toString(),
      if (wholeSalePrice != null) 'wholesale_price': wholeSalePrice.toString(),
      if (quantity != null) 'quantity': quantity.toString(),
    };
  }
}
