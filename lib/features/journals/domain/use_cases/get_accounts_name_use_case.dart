import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/journals/domain/repositories/journal_repository.dart';

class GetAccountsNameUseCase {
  final JournalRepository journalRepository;

  GetAccountsNameUseCase({required this.journalRepository});

  Future<Either<Failure, Map<String, dynamic>>> call() async {
    return await journalRepository.getAccountsName();
  }
}
