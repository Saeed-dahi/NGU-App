import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/features/accounts/account_information/data/data_sources/account_information_data_source.dart';
import 'package:ngu_app/features/accounts/account_information/data/models/account_information_model.dart';
import 'package:ngu_app/features/accounts/account_information/domain/entities/account_information_entity.dart';
import 'package:ngu_app/features/accounts/account_information/domain/repositories/account_information_repository.dart';

class AccountInformationRepositoryImpl implements AccountInformationRepository {
  final ApiHelper apiHelper;
  final AccountInformationDataSource accountInformationDataSource;

  AccountInformationRepositoryImpl(
      {required this.apiHelper, required this.accountInformationDataSource});
  @override
  Future<Either<Failure, AccountInformationEntity>> showAccountInformation(
      int accountId) async {
    return await apiHelper.safeApiCall(
        () => accountInformationDataSource.showAccountInformation(accountId));
  }

  @override
  Future<Either<Failure, Unit>> updatedAccountInformation(
      AccountInformationEntity accountInformationEntity,
      List<File> files,
      List<String> filesToDelete) async {
    return await apiHelper.safeApiCall(() =>
        accountInformationDataSource.updatedAccountInformation(
            getAccountInformationModel(accountInformationEntity),
            files,
            filesToDelete));
  }

  AccountInformationModel getAccountInformationModel(
      AccountInformationEntity account) {
    return AccountInformationModel(
        id: account.id,
        phone: account.phone,
        mobile: account.mobile,
        fax: account.fax,
        email: account.email,
        contactPersonName: account.contactPersonName,
        address: account.address,
        description: account.description,
        infoInInvoice: account.infoInInvoice,
        barcode: account.barcode,
        files: account.files);
  }
}
