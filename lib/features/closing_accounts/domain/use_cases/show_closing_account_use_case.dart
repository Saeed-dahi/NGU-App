import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_entity.dart';
import 'package:ngu_app/features/closing_accounts/domain/repositories/closing_account_repository.dart';

class ShowClosingAccountUseCase {
  final ClosingAccountRepository closingAccountRepository;

  ShowClosingAccountUseCase({required this.closingAccountRepository});

  Future<Either<Failure, ClosingAccountEntity>> call(
      int accountId, String? direction) async {
    return await closingAccountRepository.showClosingAccount(
        accountId, direction);
  }
}
