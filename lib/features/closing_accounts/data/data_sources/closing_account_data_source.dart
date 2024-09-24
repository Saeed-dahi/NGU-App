import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/app/config/api_list.dart';

import 'package:ngu_app/core/error/exception.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/features/closing_accounts/data/models/closing_account_model.dart';
import 'package:http/http.dart' as http;

abstract class ClosingAccountDataSource {
  Future<List<ClosingAccountModel>> getAllClosingAccounts();
  Future<ClosingAccountModel> showClosingAccount(
      int accountId, String? direction);
  Future<Unit> createClosingAccount(ClosingAccountModel closingAccountModel);
  Future<Unit> updateClosingAccounts(ClosingAccountModel closingAccountModel);
}

class ClosingAccountDataSourceImpl implements ClosingAccountDataSource {
  final http.Client client;
  final NetworkConnection networkConnection;
  ClosingAccountDataSourceImpl({
    required this.client,
    required this.networkConnection,
  });

  @override
  Future<List<ClosingAccountModel>> getAllClosingAccounts() async {
    final response = await networkConnection.get(APIList.closingAccounts, {});

    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);

      List<ClosingAccountModel> closingAccountModel =
          decodedJson['data'].map<ClosingAccountModel>((closingAccount) {
        return ClosingAccountModel.fromJson(closingAccount);
      }).toList();

      return closingAccountModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ClosingAccountModel> showClosingAccount(
      int accountId, String? direction) async {
    final response = await networkConnection
        .get('${APIList.closingAccounts}/$accountId', {'direction': direction});

    var decodedJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      ClosingAccountModel closingAccountModel =
          ClosingAccountModel.fromJson(decodedJson['data']);

      return closingAccountModel;
    } else {
      throw ServerException();
    }
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

    if (response.statusCode == 200) {
      return Future.value(unit);
    }
    if (response.statusCode == 422) {
      throw ValidationException(errors: decodedJson['errors']);
    } else {
      throw ServerException();
    }
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

    if (response.statusCode == 200) {
      return Future.value(unit);
    }
    if (response.statusCode == 422) {
      throw ValidationException(errors: decodedJson['errors']);
    } else {
      throw ServerException();
    }
  }
}
