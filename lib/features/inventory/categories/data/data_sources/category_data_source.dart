import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/core/error/error_handler.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/features/inventory/categories/data/models/category_model.dart';

abstract class CategoryDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<Unit> createCategory(CategoryModel category);
  Future<Unit> updateCategory(CategoryModel category);
}

class CategoryDataSourceImpl implements CategoryDataSource {
  final NetworkConnection networkConnection;

  CategoryDataSourceImpl({required this.networkConnection});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await networkConnection.get(APIList.category, {});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    List<CategoryModel> categories =
        decodedJson['data'].map<CategoryModel>((category) {
      return CategoryModel.fromJson(category);
    }).toList();

    return categories;
  }

  @override
  Future<Unit> createCategory(CategoryModel category) async {
    final response =
        await networkConnection.post(APIList.category, category.toJson());

    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return unit;
  }

  @override
  Future<Unit> updateCategory(CategoryModel category) async {
    final response = await networkConnection.put(
        '${APIList.category}/${category.id}', category.toJson());

    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return unit;
  }
}
