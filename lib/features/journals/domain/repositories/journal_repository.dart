import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/features/transactions/domain/entities/transaction_entity.dart';
import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';

abstract class JournalRepository {
  Future<Either<Failure, List<JournalEntity>>> getAllJournals();
  Future<Either<Failure, JournalEntity>> showJournal(int journalId,String? direction);
  Future<Either<Failure, Unit>> createJournal(
      JournalEntity journalEntity, List<TransactionEntity> transactions);
  Future<Either<Failure, Unit>> updateJournal(
      JournalEntity journalEntity, List<TransactionEntity> transactions);
}
