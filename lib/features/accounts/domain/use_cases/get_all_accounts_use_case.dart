import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/domain/repositories/account_repository.dart';

class GetAllAccountsUseCase {
  final AccountRepository accountRepository;

  GetAllAccountsUseCase({required this.accountRepository});

  Future<Either<Failure, List<AccountEntity>>> call() async {
    return await accountRepository.getAllAccounts();
  }
}
