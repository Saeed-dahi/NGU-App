import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_entity.dart';
import 'package:ngu_app/features/closing_accounts/domain/repositories/closing_account_repository.dart';

class CreateClosingAccountUseCase {
  final ClosingAccountRepository closingAccountRepository;

  CreateClosingAccountUseCase({required this.closingAccountRepository});

  Future<Either<Failure, Unit>> call(
      ClosingAccountEntity closingAccountEntity) async {
    return await closingAccountRepository
        .createClosingAccount(closingAccountEntity);
  }
}
