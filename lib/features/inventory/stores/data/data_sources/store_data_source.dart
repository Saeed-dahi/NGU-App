import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/core/error/error_handler.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/features/inventory/stores/data/models/store_model.dart';

abstract class StoreDataSource {
  Future<List<StoreModel>> getStores();
  Future<Unit> createStore(StoreModel store);
  Future<Unit> updateStore(StoreModel store);
}

class StoreDataSourceWithHttp implements StoreDataSource {
  final NetworkConnection networkConnection;

  StoreDataSourceWithHttp({required this.networkConnection});

  @override
  Future<List<StoreModel>> getStores() async {
    final response = await networkConnection.get(APIList.store, {});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    List<StoreModel> stores = decodedJson['data'].map<StoreModel>((store) {
      return StoreModel.fromJson(store);
    }).toList();

    return stores;
  }

  @override
  Future<Unit> createStore(StoreModel store) async {
    final response =
        await networkConnection.post(APIList.store, store.toJson());
    var decodedJson = jsonDecode(response.body);
    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return unit;
  }

  @override
  Future<Unit> updateStore(StoreModel store) async {
    final response = await networkConnection.put(APIList.store, store.toJson());
    var decodedJson = jsonDecode(response.body);
    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return unit;
  }
}
