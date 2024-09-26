import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/domain/repositories/account_repository.dart';

class UpdateAccountUseCase {
  final AccountRepository accountRepository;

  UpdateAccountUseCase({required this.accountRepository});

  Future<Either<Failure, Unit>> call(AccountEntity accountEntity) async {
    return await accountRepository.updateAccount(accountEntity);
  }
}
