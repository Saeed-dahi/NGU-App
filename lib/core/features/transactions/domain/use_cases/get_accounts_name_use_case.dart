import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/accounts/domain/repositories/account_repository.dart';

class GetAccountsNameUseCase {
  final AccountRepository accountRepository;

  GetAccountsNameUseCase({required this.accountRepository});

  Future<Either<Failure, Map<String, dynamic>>> call() async {
    return await accountRepository.getAccountsName();
  }
}
