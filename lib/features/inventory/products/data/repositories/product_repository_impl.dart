import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/features/inventory/products/data/data_sources/product_data_source.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_entity.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_unit_entity.dart';
import 'package:ngu_app/features/inventory/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource productDataSource;
  final ApiHelper apiHelper;

  ProductRepositoryImpl(
      {required this.productDataSource, required this.apiHelper});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    return await apiHelper.safeApiCall(() => productDataSource.getProducts());
  }

  @override
  Future<Either<Failure, ProductEntity>> showProduct(
      int id, String? direction) async {
    return await apiHelper
        .safeApiCall(() => productDataSource.showProduct(id, direction));
  }

  @override
  Future<Either<Failure, ProductEntity>> createProduct(
      ProductEntity product) async {
    return await apiHelper
        .safeApiCall(() => productDataSource.createProduct(product.toModel()));
  }

  @override
  Future<Either<Failure, Unit>> updateProducts(ProductEntity product,
      List<File> file, List<String> filesToDelete) async {
    return await apiHelper.safeApiCall(() => productDataSource.updateProduct(
        product.toModel(), file, filesToDelete));
  }

  @override
  Future<Either<Failure, Unit>> createProductUnit(
      ProductUnitEntity productUnitEntity, int? baseUnitId) async {
    return await apiHelper.safeApiCall(() => productDataSource
        .createProductUnit(productUnitEntity.toModel(), baseUnitId));
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProductUnit(
      ProductUnitEntity productUnitEntity) async {
    return await apiHelper.safeApiCall(
        () => productDataSource.updateProductUnit(productUnitEntity.toModel()));
  }
}
