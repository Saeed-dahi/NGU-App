import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';
import 'package:ngu_app/features/journals/domain/repositories/journal_repository.dart';

class GetAllJournalsUseCase {
  final JournalRepository journalRepository;

  GetAllJournalsUseCase({required this.journalRepository});

  Future<Either<Failure, List<JournalEntity>>> call() async {
    return await journalRepository.getAllJournals();
  }
}
