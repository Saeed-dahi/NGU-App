import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/accounts/domain/repositories/account_repository.dart';

class GetSuggestionCodeUseCase {
  final AccountRepository accountRepository;

  GetSuggestionCodeUseCase({required this.accountRepository});

  Future<Either<Failure, String>> call(String parentId) async {
    return await accountRepository.getSuggestionCode(parentId);
  }
}
