import 'dart:async';

import 'package:dartz/dartz.dart';

import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/core/network/network_info.dart';
import 'package:ngu_app/features/closing_accounts/data/data_sources/closing_account_data_source.dart';
import 'package:ngu_app/features/closing_accounts/data/models/closing_account_model.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_entity.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_statement_entity.dart';
import 'package:ngu_app/features/closing_accounts/domain/repositories/closing_account_repository.dart';

class ClosingAccountRepositoryImpl implements ClosingAccountRepository {
  final NetworkInfo networkInfo;
  final ApiHelper apiHelper;
  final ClosingAccountDataSource closingAccountDataSource;

  ClosingAccountRepositoryImpl(
      {required this.networkInfo,
      required this.closingAccountDataSource,
      required this.apiHelper});

  @override
  Future<Either<Failure, List<ClosingAccountEntity>>>
      getAllClosingAccounts() async {
    return apiHelper
        .safeApiCall(() => closingAccountDataSource.getAllClosingAccounts());
  }

  @override
  Future<Either<Failure, ClosingAccountEntity>> showClosingAccount(
      int accountId, String? direction) async {
    return apiHelper.safeApiCall(() =>
        closingAccountDataSource.showClosingAccount(accountId, direction));
  }

  @override
  Future<Either<Failure, Unit>> createClosingAccount(
      ClosingAccountEntity closingAccountEntity) async {
    ClosingAccountModel closingAccountModel =
        getClosingAccountModel(closingAccountEntity);

    return apiHelper.safeApiCall(
      () => closingAccountDataSource.createClosingAccount(closingAccountModel),
    );
  }

  @override
  Future<Either<Failure, Unit>> updateClosingAccount(
      ClosingAccountEntity closingAccountEntity) async {
    ClosingAccountModel closingAccountModel =
        getClosingAccountModel(closingAccountEntity);

    return apiHelper.safeApiCall(() =>
        closingAccountDataSource.updateClosingAccounts(closingAccountModel));
  }

  @override
  Future<Either<Failure, Map<String, ClosingAccountStatementEntity>>>
      closingAccountStatement(double? completedProductsValue) {
    return apiHelper.safeApiCall(() => closingAccountDataSource
        .closingAccountStatement(completedProductsValue));
  }

  ClosingAccountModel getClosingAccountModel(
      ClosingAccountEntity closingAccountEntity) {
    return ClosingAccountModel(
        id: closingAccountEntity.id,
        arName: closingAccountEntity.arName,
        enName: closingAccountEntity.enName,
        createdAt: closingAccountEntity.createdAt,
        updatedAt: closingAccountEntity.updatedAt);
  }
}
