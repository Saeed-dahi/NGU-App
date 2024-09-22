import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_entity.dart';
import 'package:ngu_app/features/closing_accounts/domain/repositories/closing_account_repository.dart';

class GetAllClosingAccountsUseCase {
  final ClosingAccountRepository closingAccountRepository;

  GetAllClosingAccountsUseCase({required this.closingAccountRepository});

  Future<Either<Failure, List<ClosingAccountEntity>>> call() async {
    return await closingAccountRepository.getAllClosingAccounts();
  }
}
