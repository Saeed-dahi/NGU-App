import 'package:ngu_app/features/inventory/categories/data/models/category_model.dart';
import 'package:ngu_app/features/inventory/products/data/models/product_unit_model.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel(
      {super.id,
      required super.arName,
      required super.enName,
      required super.code,
      super.barcode,
      super.category,
      super.description,
      super.files,
      super.type,
      super.units});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      arName: json['ar_name'],
      enName: json['en_name'],
      code: json['code'],
      barcode: json['barcode'] ?? '',
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      description: json['description'] ?? '',
      files: json['file'] != null ? List<String>.from(json['file']) : null,
      type: json['type'],
      units: json['units']
          .map<ProductUnitModel>((unit) => ProductUnitModel.fromJson(unit))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id.toString(),
      'ar_name': arName,
      'en_name': enName,
      'code': code,
      if (barcode != null) 'barcode': barcode,
      if (category != null) 'category_id': category!.id.toString(),
      if (description != null) 'description': description,
      if (files != null) 'file': files,
      if (type != null) 'type': type,
    };
  }
}
