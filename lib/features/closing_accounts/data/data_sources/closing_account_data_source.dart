import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/core/error/error_handler.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/features/closing_accounts/data/models/closing_account_model.dart';

abstract class ClosingAccountDataSource {
  Future<List<ClosingAccountModel>> getAllClosingAccounts();
  Future<ClosingAccountModel> showClosingAccount(
      int accountId, String? direction);
  Future<Unit> createClosingAccount(ClosingAccountModel closingAccountModel);
  Future<Unit> updateClosingAccounts(ClosingAccountModel closingAccountModel);
}

class ClosingAccountDataSourceImpl implements ClosingAccountDataSource {
  final NetworkConnection networkConnection;
  ClosingAccountDataSourceImpl({
    required this.networkConnection,
  });

  @override
  Future<List<ClosingAccountModel>> getAllClosingAccounts() async {
    final response = await networkConnection.get(APIList.closingAccounts, {});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    List<ClosingAccountModel> closingAccountModel =
        decodedJson['data'].map<ClosingAccountModel>((closingAccount) {
      return ClosingAccountModel.fromJson(closingAccount);
    }).toList();

    return closingAccountModel;
  }

  @override
  Future<ClosingAccountModel> showClosingAccount(
      int accountId, String? direction) async {
    final response = await networkConnection
        .get('${APIList.closingAccounts}/$accountId', {'direction': direction});

    var decodedJson = jsonDecode(response.body);
    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    ClosingAccountModel closingAccountModel =
        ClosingAccountModel.fromJson(decodedJson['data']);

    return closingAccountModel;
  }

  @override
  Future<Unit> createClosingAccount(
      ClosingAccountModel closingAccountModel) async {
    final body = {
      'ar_name': closingAccountModel.arName,
      'en_name': closingAccountModel.enName,
    };
    var response = await networkConnection.post(APIList.closingAccounts, body);
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return unit;
  }

  @override
  Future<Unit> updateClosingAccounts(
      ClosingAccountModel closingAccountModel) async {
    final body = {
      'ar_name': closingAccountModel.arName,
      'en_name': closingAccountModel.enName,
    };
    var response = await networkConnection.put(
        '${APIList.closingAccounts}/ ${closingAccountModel.id}', body);
    var decodedJson = jsonDecode(response.body);
    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return unit;
  }
}
