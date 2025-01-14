import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/core/error/error_handler.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/features/inventory/products/data/models/product_model.dart';
import 'package:ngu_app/features/inventory/products/data/models/product_unit_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> showProduct(int id, String? direction);
  Future<ProductModel> createProduct(ProductModel product);
  Future<Unit> updateProduct(
      ProductModel product, List<File> file, List<String> filesToDelete);
  Future<Unit> createProductUnit(ProductUnitModel productUnit, int? baseUnitId);
  Future<ProductModel> updateProductUnit(ProductUnitModel productUnit);
}

class ProductDataSourceImpl implements ProductDataSource {
  final NetworkConnection networkConnection;

  ProductDataSourceImpl({required this.networkConnection});

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await networkConnection.get(APIList.product, {});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    List<ProductModel> products = decodedJson['data']
        .map<ProductModel>((product) => ProductModel.fromJson(product))
        .toList();

    return products;
  }

  @override
  Future<ProductModel> showProduct(int id, String? direction) async {
    final response = await networkConnection
        .get('${APIList.product}/$id', {'direction': direction});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    ProductModel product = ProductModel.fromJson(decodedJson['data']);

    return product;
  }

  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    final response =
        await networkConnection.post(APIList.product, product.toJson());
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return ProductModel.fromJson(decodedJson['data']);
  }

  @override
  Future<Unit> updateProduct(
      ProductModel product, List<File> file, List<String> filesToDelete) async {
    final response = await networkConnection.httpPostMultipartRequestWithFields(
        '${APIList.product}/${product.id}',
        file,
        'file[]',
        product.toJson(),
        filesToDelete);

    var responseBody = await response.stream.bytesToString();

    var decodedJson = jsonDecode(responseBody);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return unit;
  }

  @override
  Future<Unit> createProductUnit(
      ProductUnitModel productUnit, int? baseUnitId) async {
    final response = await networkConnection.post(APIList.productUnit, {
      ...productUnit.toJson(),
      if (baseUnitId != null) 'base_product_unit_id': baseUnitId.toString()
    });

    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return unit;
  }

  @override
  Future<ProductModel> updateProductUnit(ProductUnitModel productUnit) async {
    final response = await networkConnection.put(
        '${APIList.productUnit}/${productUnit.id}', productUnit.toJson());

    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    ProductModel product = ProductModel.fromJson(decodedJson['data']);

    return product;
  }
}
