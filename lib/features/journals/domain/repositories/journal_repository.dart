import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';

import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';

abstract class JournalRepository {
  Future<Either<Failure, List<JournalEntity>>> getAllJournals();
  Future<Either<Failure, JournalEntity>> showJournal(
      int journalId, String? direction);
  Future<Either<Failure, JournalEntity>> createJournal(
      JournalEntity journalEntity);
  Future<Either<Failure, JournalEntity>> updateJournal(
      JournalEntity journalEntity);
}
