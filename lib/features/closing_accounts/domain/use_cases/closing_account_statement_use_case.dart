import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_statement_entity.dart';
import 'package:ngu_app/features/closing_accounts/domain/repositories/closing_account_repository.dart';

class ClosingAccountStatementUseCase {
  final ClosingAccountRepository closingAccountRepository;

  ClosingAccountStatementUseCase({required this.closingAccountRepository});

  Future<Either<Failure, Map<String, ClosingAccountStatementEntity>>> call() async {
    return await closingAccountRepository.closingAccountStatement();
  }
}
