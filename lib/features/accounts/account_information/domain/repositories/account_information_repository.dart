import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/accounts/account_information/domain/entities/account_information_entity.dart';

abstract class AccountInformationRepository {
  Future<Either<Failure, AccountInformationEntity>> showAccountInformation(
      int accountId);
  Future<Either<Failure, Unit>> updatedAccountInformation(
      AccountInformationEntity accountInformationEntity);
}
