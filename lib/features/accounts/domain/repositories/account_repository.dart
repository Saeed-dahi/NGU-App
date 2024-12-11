import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_statement_entity.dart';

abstract class AccountRepository {
  Future<Either<Failure, List<AccountEntity>>> getAllAccounts();
  Future<Either<Failure, List<AccountEntity>>> searchInAccounts(String quey);
  Future<Either<Failure, AccountEntity>> showAccount(int id, String? direction);

  Future<Either<Failure, Unit>> createAccount(AccountEntity accountEntity);
  Future<Either<Failure, Unit>> updateAccount(AccountEntity accountEntity);

  Future<Either<Failure, String>> getSuggestionCode(int parentId);

  Future<Either<Failure, AccountStatementEntity>> accountStatement(
      int accountId);

  Future<Either<Failure, Map<String, dynamic>>> getAccountsName();
}
