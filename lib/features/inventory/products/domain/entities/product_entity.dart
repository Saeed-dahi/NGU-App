import 'dart:core';
import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/inventory/categories/domain/entities/category_entity.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_unit_entity.dart';

class ProductEntity extends Equatable {
  final int? id;
  final String arName;
  final String enName;
  final String code;
  final String? description;
  final String? barcode;
  final String? type;
  final CategoryEntity? category;
  final List<String>? files;
  final List<ProductUnitEntity>? units;

  const ProductEntity(
      {this.id,
      required this.arName,
      required this.enName,
      required this.code,
      this.description,
      this.barcode,
      this.type,
      this.category,
      this.files,
      this.units});

  @override
  List<Object?> get props => [
        id,
        arName,
        enName,
        code,
        description,
        barcode,
        type,
        category,
        files,
        units
      ];
}
