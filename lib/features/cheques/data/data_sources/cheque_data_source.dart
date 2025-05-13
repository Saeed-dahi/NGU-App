import 'dart:convert';

import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/core/error/error_handler.dart';
import 'package:ngu_app/core/features/upload/data/file_upload_model.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/features/cheques/data/models/cheque_model.dart';
import 'package:ngu_app/features/cheques/data/models/parmas/multiple_cheques_params_model.dart';

abstract class ChequeDataSource {
  Future<ChequeModel> showCheque(int id, String? direction);
  Future<List<ChequeModel>> getAllCheques();
  Future<ChequeModel> createCheque(ChequeModel cheque, FileUploadModel files);
  Future<ChequeModel> updateCheque(ChequeModel cheque, FileUploadModel files);
  Future<ChequeModel> depositCheque(int id);
  Future<List<ChequeModel>> getChequesPerAccount(int accountId);
  Future<bool> createMultipleCheques(ChequeModel cheque,
      MultipleChequesParamsModel multipleChequesParamsEntity);
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
  Future<ChequeModel> createCheque(
      ChequeModel cheque, FileUploadModel files) async {
    final response = await networkConnection.httpPostMultipartRequestWithFields(
        APIList.cheque,
        files.files,
        'image[]',
        cheque.toJson(),
        files.filesToDelete);
    var responseBody = await response.stream.bytesToString();
    var decodedJson = jsonDecode(responseBody);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    ChequeModel chequeModel = ChequeModel.fromJson(decodedJson['data']);

    return chequeModel;
  }

  @override
  Future<ChequeModel> updateCheque(
      ChequeModel cheque, FileUploadModel files) async {
    final response = await networkConnection.httpPostMultipartRequestWithFields(
        '${APIList.cheque}/${cheque.id}',
        files.files,
        'image[]',
        cheque.toJson(),
        files.filesToDelete);
    var responseBody = await response.stream.bytesToString();
    var decodedJson = jsonDecode(responseBody);

    ChequeModel chequeModel = ChequeModel.fromJson(decodedJson['data']);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

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
        await networkConnection.get('${APIList.accountCheques}/$accountId', {});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    List<ChequeModel> cheques = decodedJson['data']
        .map<ChequeModel>((cheque) => ChequeModel.fromJson(cheque))
        .toList();

    return cheques;
  }

  @override
  Future<bool> createMultipleCheques(ChequeModel cheque,
      MultipleChequesParamsModel multipleChequesParamsEntity) async {
    final response =
        await networkConnection.post(APIList.createMultipleCheques, {
      'cheque': cheque.toJson(),
      'multiple_cheques_params': multipleChequesParamsEntity.toJson()
    });
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    var status = decodedJson != null ? true : false;

    return status;
  }
}
