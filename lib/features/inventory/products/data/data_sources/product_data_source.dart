import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/core/error/error_handler.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/features/inventory/products/data/models/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> showProduct(int id, String? direction);
  Future<Unit> createProduct(ProductModel product);
  Future<Unit> updateProduct(ProductModel product);
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
  Future<Unit> createProduct(ProductModel product) async {
    final response =
        await networkConnection.post(APIList.product, product.toJson());
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return unit;
  }

  @override
  Future<Unit> updateProduct(ProductModel product) async {
    final response = await networkConnection.post(
        '${APIList.product}/${product.id}', product.toJson());
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return unit;
  }
}
