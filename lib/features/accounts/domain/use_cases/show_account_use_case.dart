import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/domain/repositories/account_repository.dart';

class ShowAccountUseCase {
  final AccountRepository accountRepository;

  ShowAccountUseCase({required this.accountRepository});

  Future<Either<Failure, AccountEntity>> call(
      String accountId, String? direction) async {
    return await accountRepository.showAccount(accountId, direction);
  }
}
