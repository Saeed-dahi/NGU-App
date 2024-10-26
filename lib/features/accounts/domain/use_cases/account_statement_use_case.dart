import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_statement_entity.dart';

import 'package:ngu_app/features/accounts/domain/repositories/account_repository.dart';

class AccountStatementUseCase {
  final AccountRepository accountRepository;

  AccountStatementUseCase({required this.accountRepository});

  Future<Either<Failure, AccountStatementEntity>> call(int accountId) async {
    return await accountRepository.accountStatement(accountId);
  }
}
