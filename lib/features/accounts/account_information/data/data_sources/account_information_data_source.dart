import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/core/error/error_handler.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/features/accounts/account_information/data/models/account_information_model.dart';

abstract class AccountInformationDataSource {
  Future<AccountInformationModel> showAccountInformation(int accountId);
  Future<Unit> updatedAccountInformation(AccountInformationModel accountModel);
}

class AccountInformationDataSourceWithHttp
    implements AccountInformationDataSource {
  final NetworkConnection networkConnection;

  AccountInformationDataSourceWithHttp({required this.networkConnection});
  @override
  Future<AccountInformationModel> showAccountInformation(int accountId) async {
    final response = await networkConnection
        .get('${APIList.accountInformation}/$accountId', {});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    AccountInformationModel accountInformationModel =
        AccountInformationModel.fromJson(decodedJson['data']);

    return accountInformationModel;
  }

  @override
  Future<Unit> updatedAccountInformation(
      AccountInformationModel accountModel) async {
    final response =
        await networkConnection.get(APIList.accountInformation, {});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return unit;
  }
}
