import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/core/error/error_handler.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/features/accounts/account_information/data/models/account_information_model.dart';

abstract class AccountInformationDataSource {
  Future<AccountInformationModel> showAccountInformation(int accountId);
  Future<Unit> updatedAccountInformation(AccountInformationModel accountModel,
      List<File> file, List<String> filesToDelete);
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
      AccountInformationModel accountInformationModel,
      List<File> file,
      List<String> filesToDelete) async {
    final response = await networkConnection.httpPostMultipartRequestWithFields(
        '${APIList.accountInformation}/${accountInformationModel.id}',
        file,
        'file[]',
        accountInformationModel.toJson(),
        filesToDelete);

    var responseBody = await response.stream.bytesToString();
    var decodedJson = jsonDecode(responseBody);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    return unit;
  }
}
