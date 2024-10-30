import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/core/error/error_handler.dart';
import 'package:ngu_app/core/features/transactions/data/models/transaction_model.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/features/journals/data/models/journal_model.dart';

abstract class JournalDataSource {
  Future<List<JournalModel>> getAllJournals();
  Future<JournalModel> showJournal(int journalId, String? direction);
  Future<Unit> createJournal(
      JournalModel journalModel, List<TransactionModel> transactionModel);
  Future<Unit> updateJournal(
      JournalModel journalModel, List<TransactionModel> transactionModel);
}

class JournalDataSourceImpl implements JournalDataSource {
  final NetworkConnection networkConnection;

  JournalDataSourceImpl({required this.networkConnection});

  @override
  Future<List<JournalModel>> getAllJournals() async {
    final response = await networkConnection.get(APIList.journal, {});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    List<JournalModel> journals = decodedJson['data'].map((journal) {
      return JournalModel.fromJson(journal);
    }).toList();

    return journals;
  }

  @override
  Future<JournalModel> showJournal(int journalId, String? direction) async {
    final response = await networkConnection
        .get('${APIList.journal}/$journalId', {'direction': direction});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    JournalModel journal = JournalModel.fromJson(decodedJson['data']);

    return journal;
  }

  @override
  Future<Unit> createJournal(JournalModel journalModel,
      List<TransactionModel> transactionModel) async {
    final response = await networkConnection.post(APIList.journal,
        {'journal': journalModel.toJson(), 'entires[]': transactionModel});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);
    return unit;
  }

  @override
  Future<Unit> updateJournal(JournalModel journalModel,
      List<TransactionModel> transactionModel) async {
    final response = await networkConnection.put(APIList.journal,
        {'journal': journalModel.toJson(), 'entires[]': transactionModel});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);
    return unit;
  }
}
