import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';
import 'package:ngu_app/features/journals/domain/repositories/journal_repository.dart';

class ShowJournalUseCase {
  final JournalRepository journalRepository;

  ShowJournalUseCase({required this.journalRepository});
  Future<Either<Failure, JournalEntity>> call(
      int journalId, String? direction) async {
    return await journalRepository.showJournal(journalId, direction);
  }
}
