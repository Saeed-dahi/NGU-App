import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';

import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';
import 'package:ngu_app/features/journals/domain/repositories/journal_repository.dart';

class UpdateJournalUseCase {
  final JournalRepository journalRepository;

  UpdateJournalUseCase({required this.journalRepository});

  Future<Either<Failure, JournalEntity>> call(
      JournalEntity journalEntity) async {
    return await journalRepository.createJournal(journalEntity);
  }
}
