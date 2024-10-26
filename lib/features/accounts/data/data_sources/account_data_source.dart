import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/core/error/error_handler.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/features/accounts/data/models/account_model.dart';
import 'package:ngu_app/features/accounts/data/models/account_statement_model.dart';

abstract class AccountDataSource {
  Future<List<AccountModel>> getAllAccounts();
  Future<List<AccountModel>> searchInAccounts(String query);
  Future<AccountModel> showAccount(int id, String? direction);
  Future<Unit> createAccount(AccountModel accountModel);
  Future<Unit> updateAccount(AccountModel accountModel);
  Future<String> getSuggestionCode(int parentId);
  Future<AccountStatementModel> accountStatement(int accountId);
}

class AccountDataSourceWithHttp implements AccountDataSource {
  final NetworkConnection networkConnection;

  AccountDataSourceWithHttp({required this.networkConnection});

  @override
  Future<Unit> createAccount(AccountModel accountModel) async {
    final response = await networkConnection.post(
      APIList.account,
      accountModel.toJson(),
    );

    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return unit;
  }

  @override
  Future<List<AccountModel>> getAllAccounts() async {
    final response = await networkConnection.get(APIList.account, {});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    List<AccountModel> allAccounts =
        decodedJson['data'].map<AccountModel>((account) {
      return AccountModel.fromJson(account);
    }).toList();

    return allAccounts;
  }

  @override
  Future<AccountModel> showAccount(int id, String? direction) async {
    final response = await networkConnection
        .get('${APIList.account}/$id', {'direction': direction});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    AccountModel account = AccountModel.fromJson(decodedJson['data']);

    return account;
  }

  @override
  Future<String> getSuggestionCode(int parentId) async {
    final response = await networkConnection
        .get(APIList.getSuggestionCode, {'parent_id': parentId.toString()});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);
    String code = decodedJson['data'].toString();

    return Future.value(code);
  }

  @override
  Future<Unit> updateAccount(AccountModel accountModel) async {
    final response = await networkConnection.put(
        '${APIList.account}/${accountModel.id}', accountModel.toJson());

    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);
    return unit;
  }

  @override
  Future<List<AccountModel>> searchInAccounts(String query) async {
    final response = await networkConnection
        .get(APIList.searchAccount, {'search_query': query});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    List<AccountModel> allAccounts =
        decodedJson['data'].map<AccountModel>((account) {
      return AccountModel.fromJson(account);
    }).toList();

    return allAccounts;
  }

  @override
  Future<AccountStatementModel> accountStatement(int accountId) async {
    final response = await networkConnection
        .get('${APIList.accountStatement}/$accountId', {});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    AccountStatementModel accountStatementModel =
        AccountStatementModel.fromJson(decodedJson['data']);

    return accountStatementModel;
  }
}
