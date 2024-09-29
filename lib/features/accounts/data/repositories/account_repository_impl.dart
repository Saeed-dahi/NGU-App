import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/features/accounts/data/data_sources/account_data_source.dart';
import 'package:ngu_app/features/accounts/data/models/account_model.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountDataSource accountDataSource;
  final ApiHelper apiHelper;

  AccountRepositoryImpl(
      {required this.accountDataSource, required this.apiHelper});

  @override
  Future<Either<Failure, List<AccountEntity>>> getAllAccounts() async {
    return await apiHelper
        .safeApiCall(() => accountDataSource.getAllAccounts());
  }

  @override
  Future<Either<Failure, AccountEntity>> showAccount(
      int id, String? direction) async {
    return await apiHelper
        .safeApiCall(() => accountDataSource.showAccount(id, direction));
  }

  @override
  Future<Either<Failure, Unit>> createAccount(
      AccountEntity accountEntity) async {
    return apiHelper.safeApiCall(
        () => accountDataSource.createAccount(getAccountModel(accountEntity)));
  }

  @override
  Future<Either<Failure, Unit>> updateAccount(
      AccountEntity accountEntity) async {
    return await apiHelper.safeApiCall(
        () => accountDataSource.updateAccount(getAccountModel(accountEntity)));
  }

  @override
  Future<Either<Failure, String>> getSuggestionCode(int parentId) async {
    return await apiHelper
        .safeApiCall(() => accountDataSource.getSuggestionCode(parentId));
  }

  AccountModel getAccountModel(AccountEntity accountEntity) {
    return AccountModel(
        id: accountEntity.id,
        code: accountEntity.code,
        arName: accountEntity.arName,
        enName: accountEntity.enName,
        accountType: accountEntity.accountType,
        accountNature: accountEntity.accountNature,
        accountCategory: accountEntity.accountCategory,
        balance: accountEntity.balance,
        closingAccountId: accountEntity.closingAccountId,
        parentId: accountEntity.parentId,
        createdAt: accountEntity.createdAt,
        updatedAt: accountEntity.updatedAt);
  }
}
