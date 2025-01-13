import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/features/inventory/products/data/data_sources/product_data_source.dart';
import 'package:ngu_app/features/inventory/products/data/models/product_model.dart';
import 'package:ngu_app/features/inventory/products/data/models/product_unit_model.dart';
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
    return await apiHelper.safeApiCall(
        () => productDataSource.createProduct(getProductModel(product)));
  }

  @override
  Future<Either<Failure, Unit>> updateProducts(ProductEntity product,
      List<File> file, List<String> filesToDelete) async {
    return await apiHelper.safeApiCall(() => productDataSource.updateProduct(
        getProductModel(product), file, filesToDelete));
  }

  ProductModel getProductModel(ProductEntity product) {
    return ProductModel(
        id: product.id,
        arName: product.arName,
        enName: product.enName,
        code: product.code,
        type: product.type,
        barcode: product.barcode,
        description: product.description,
        category: product.category);
  }

  @override
  Future<Either<Failure, Unit>> createProductUnit(
      ProductUnitEntity productUnitEntity, int? baseUnitId) async {
    return await apiHelper.safeApiCall(() => productDataSource
        .createProductUnit(getProductUnitModel(productUnitEntity), baseUnitId));
  }

  @override
  Future<Either<Failure, Unit>> updateProductUnit(
      ProductUnitEntity productUnitEntity) async {
    return await apiHelper.safeApiCall(() => productDataSource
        .updateProductUnit(getProductUnitModel(productUnitEntity)));
  }

  ProductUnitModel getProductUnitModel(ProductUnitEntity productUnit) {
    return ProductUnitModel(
        id: productUnit.id,
        productId: productUnit.productId,
        unitId: productUnit.unitId,
        endPrice: productUnit.endPrice,
        exportPrice: productUnit.exportPrice,
        importPrice: productUnit.importPrice,
        wholeSalePrice: productUnit.wholeSalePrice);
  }
}
