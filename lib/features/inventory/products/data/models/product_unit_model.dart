import 'package:ngu_app/features/inventory/products/domain/entities/product_unit_entity.dart';

class ProductUnitModel extends ProductUnitEntity {
  const ProductUnitModel({
    super.id,
    required super.productId,
    required super.unitId,
    super.arName,
    super.enName,
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
        arName: json['ar_name'] ?? '',
        enName: json['en_name'] ?? '',
        conversionFactor: json['conversion_factor'],
        endPrice: json['end_price'],
        exportPrice: json['export_price'],
        importPrice: json['import_price'],
        wholeSalePrice: json['whole_sale_price'],
        quantity: json['quantity'],
        subUnit: json['sub_unit']
                .map<ProductUnitModel>(
                    (unit) => ProductUnitModel.fromJson(unit))
                .toList() ??
            []);
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id.toString(),
      'product_id': productId.toString(),
      'unit_id': unitId.toString(),
      if (conversionFactor != null)
        'conversion_factor': conversionFactor.toString(),
      if (endPrice != null) 'end_price': endPrice.toString(),
      if (exportPrice != null) 'export_price': exportPrice.toString(),
      if (importPrice != null) 'import_price': importPrice.toString(),
      if (wholeSalePrice != null) 'whole_sale_price': wholeSalePrice.toString(),
      if (quantity != null) 'quantity': quantity.toString(),
    };
  }
}
