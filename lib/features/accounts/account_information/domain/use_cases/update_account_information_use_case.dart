import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/accounts/account_information/domain/entities/account_information_entity.dart';
import 'package:ngu_app/features/accounts/account_information/domain/repositories/account_information_repository.dart';

class UpdateAccountInformationUseCase {
  final AccountInformationRepository accountInformationRepository;

  UpdateAccountInformationUseCase({required this.accountInformationRepository});
  Future<Either<Failure, Unit>> call(
      AccountInformationEntity accountInformationEntity,
      List<File> files,
      List<String> filesToDelete) async {
    return await accountInformationRepository.updatedAccountInformation(
        accountInformationEntity, files, filesToDelete);
  }
}
