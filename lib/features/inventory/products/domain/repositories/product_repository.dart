import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_entity.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_unit_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, ProductEntity>> showProduct(int id, String? direction);
  Future<Either<Failure, ProductEntity>> createProduct(ProductEntity product);
  Future<Either<Failure, Unit>> updateProducts(
      ProductEntity product, List<File> file, List<String> filesToDelete);
  Future<Either<Failure, Unit>> createProductUnit(
      ProductUnitEntity productUnitEntity, int? baseUnitId);
  Future<Either<Failure, Unit>> updateProductUnit(
      ProductUnitEntity productUnitEntity);
}
