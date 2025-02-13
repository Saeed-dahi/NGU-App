import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/accounts/account_information/domain/entities/account_information_entity.dart';
import 'package:ngu_app/features/accounts/account_information/domain/repositories/account_information_repository.dart';

class ShowAccountInformationUseCase {
  final AccountInformationRepository accountInformationRepository;

  ShowAccountInformationUseCase({required this.accountInformationRepository});
  Future<Either<Failure, AccountInformationEntity>> call(int accountId) async {
    return await accountInformationRepository.showAccountInformation(accountId);
  }
}
