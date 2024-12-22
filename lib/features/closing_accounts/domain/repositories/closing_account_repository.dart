import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_entity.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_statement_entity.dart';

abstract class ClosingAccountRepository {
  Future<Either<Failure, List<ClosingAccountEntity>>> getAllClosingAccounts();
  Future<Either<Failure, ClosingAccountEntity>> showClosingAccount(
      int accountId, String? direction);
  Future<Either<Failure, Unit>> createClosingAccount(
      ClosingAccountEntity closingAccountEntity);
  Future<Either<Failure, Unit>> updateClosingAccount(
      ClosingAccountEntity closingAccountEntity);

  Future<Either<Failure, Map<String, ClosingAccountStatementEntity>>> closingAccountStatement();
}
