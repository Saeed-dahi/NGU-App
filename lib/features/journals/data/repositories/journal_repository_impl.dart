import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/features/transactions/data/models/transaction_model.dart';

import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/features/journals/data/data_sources/journal_data_source.dart';
import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';
import 'package:ngu_app/features/journals/domain/repositories/journal_repository.dart';

class JournalRepositoryImpl implements JournalRepository {
  final ApiHelper apiHelper;
  final JournalDataSource journalDataSource;

  JournalRepositoryImpl(
      {required this.apiHelper, required this.journalDataSource});

  @override
  Future<Either<Failure, JournalEntity>> createJournal(
    JournalEntity journalEntity,
  ) async {
    return await apiHelper.safeApiCall(() => journalDataSource.createJournal(
        journalEntity.toModel(), _getTransactions(journalEntity)));
  }

  @override
  Future<Either<Failure, List<JournalEntity>>> getAllJournals() async {
    return await apiHelper
        .safeApiCall(() => journalDataSource.getAllJournals());
  }

  @override
  Future<Either<Failure, JournalEntity>> showJournal(
      int journalId, String? direction) async {
    return await apiHelper
        .safeApiCall(() => journalDataSource.showJournal(journalId, direction));
  }

  @override
  Future<Either<Failure, JournalEntity>> updateJournal(
    JournalEntity journalEntity,
  ) async {
    return await apiHelper.safeApiCall(() => journalDataSource.updateJournal(
        journalEntity.toModel(), _getTransactions(journalEntity)));
  }

  List<TransactionModel> _getTransactions(JournalEntity journalEntity) {
    return journalEntity.transactions.map((transaction) {
      return transaction.toModel();
    }).toList();
  }
}
