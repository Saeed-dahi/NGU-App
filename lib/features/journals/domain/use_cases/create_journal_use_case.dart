import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/features/transactions/domain/entities/transaction_entity.dart';
import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';
import 'package:ngu_app/features/journals/domain/repositories/journal_repository.dart';

class CreateJournalUseCase {
  final JournalRepository journalRepository;

  CreateJournalUseCase({required this.journalRepository});

  Future<Either<Failure, Unit>> call(
      JournalEntity journalEntity, List<TransactionEntity> transactions) async {
    return await journalRepository.createJournal(journalEntity, transactions);
  }
}
