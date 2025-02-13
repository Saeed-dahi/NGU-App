import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/core/error/error_handler.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/features/inventory/units/data/models/unit_model.dart';

abstract class UnitDataSource {
  Future<List<UnitModel>> getUnits(int? productId, bool? showProductUnits);
  Future<Unit> createUnit(UnitModel unitModel);
  Future<Unit> updateUnit(UnitModel unitModel);
}

class UnitDataSourceImpl implements UnitDataSource {
  final NetworkConnection networkConnection;

  UnitDataSourceImpl({required this.networkConnection});

  @override
  Future<List<UnitModel>> getUnits(
      int? productId, bool? showProductUnits) async {
    final response = await networkConnection.get(APIList.unit, {
      'product_id': productId?.toString(),
      'show_product_units': showProductUnits.toString()
    });
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    List<UnitModel> units = decodedJson['data'].map<UnitModel>((unit) {
      return UnitModel.fromJson(unit);
    }).toList();

    return units;
  }

  @override
  Future<Unit> createUnit(UnitModel unitModel) async {
    final response =
        await networkConnection.post(APIList.unit, unitModel.toJson());
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return unit;
  }

  @override
  Future<Unit> updateUnit(UnitModel unitModel) async {
    final response = await networkConnection.put(
        '${APIList.unit}/${unitModel.id}', unitModel.toJson());
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return unit;
  }
}
