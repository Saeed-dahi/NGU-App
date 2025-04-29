import 'dart:convert';

import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/core/error/error_handler.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/features/cheques/data/models/cheque_model.dart';

abstract class ChequeDataSource {
  Future<ChequeModel> showCheque(int id, String? direction);
  Future<List<ChequeModel>> getAllCheques();
  Future<ChequeModel> createCheque(ChequeModel cheque);
  Future<ChequeModel> updateCheque(ChequeModel cheque);
  Future<ChequeModel> depositCheque(int id);
  Future<List<ChequeModel>> getChequesPerAccount(int accountId);
}

class ChequeDataSourceWithHttp extends ChequeDataSource {
  final NetworkConnection networkConnection;

  ChequeDataSourceWithHttp({required this.networkConnection});

  @override
  Future<ChequeModel> showCheque(int id, String? direction) async {
    final response = await networkConnection
        .get('${APIList.cheque}/$id', {'direction': direction});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    ChequeModel chequeModel = ChequeModel.fromJson(decodedJson['data']);

    return chequeModel;
  }

  @override
  Future<List<ChequeModel>> getAllCheques() async {
    final response = await networkConnection.get(APIList.cheque, {});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    List<ChequeModel> cheques = decodedJson['data']
        .map<ChequeModel>((cheque) => ChequeModel.fromJson(cheque))
        .toList();

    return cheques;
  }

  @override
  Future<ChequeModel> createCheque(ChequeModel cheque) async {
    final response =
        await networkConnection.post(APIList.cheque, cheque.toJson());
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    ChequeModel chequeModel = ChequeModel.fromJson(decodedJson['data']);

    return chequeModel;
  }

  @override
  Future<ChequeModel> updateCheque(ChequeModel cheque) async {
    final response = await networkConnection.put(
        '${APIList.cheque}/${cheque.id}', cheque.toJson());
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    ChequeModel chequeModel = ChequeModel.fromJson(decodedJson['data']);

    return chequeModel;
  }

  @override
  Future<ChequeModel> depositCheque(int id) async {
    final response =
        await networkConnection.put('${APIList.depositCheque}/$id', {});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    ChequeModel chequeModel = ChequeModel.fromJson(decodedJson['data']);

    return chequeModel;
  }

  @override
  Future<List<ChequeModel>> getChequesPerAccount(int accountId) async {
    final response =
        await networkConnection.get('account-cheques/$accountId', {});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    List<ChequeModel> cheques = decodedJson['data']
        .map<ChequeModel>((cheque) => ChequeModel.fromJson(cheque))
        .toList();

    return cheques;
  }
}
