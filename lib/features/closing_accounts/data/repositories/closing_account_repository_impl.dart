import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/exception.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/network/network_info.dart';
import 'package:ngu_app/features/closing_accounts/data/data_sources/closing_account_data_source.dart';
import 'package:ngu_app/features/closing_accounts/data/models/closing_account_model.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_entity.dart';
import 'package:ngu_app/features/closing_accounts/domain/repositories/closing_account_repository.dart';

class ClosingAccountRepositoryImpl implements ClosingAccountRepository {
  final NetworkInfo networkInfo;
  final ClosingAccountDataSource closingAccountDataSource;

  ClosingAccountRepositoryImpl(
      {required this.networkInfo, required this.closingAccountDataSource});

  @override
  Future<Either<Failure, List<ClosingAccountEntity>>>
      getAllClosingAccounts() async {
    if (await networkInfo.isConnected) {
      try {
        final closingAccounts =
            await closingAccountDataSource.getAllClosingAccounts();

        return right(closingAccounts);
      } on ServerException {
        return left(ServerFailure());
      } catch (e) {
        return left(ServerFailure(errors: {'error': e.toString()}));
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> createClosingAccount(
      ClosingAccountEntity closingAccountEntity) async {
    ClosingAccountModel closingAccountModel =
        getClosingAccountModel(closingAccountEntity);

    if (await networkInfo.isConnected) {
      try {
        await closingAccountDataSource
            .createClosingAccount(closingAccountModel);

        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      } on ValidationException catch (messages) {
        return left(ValidationFailure(errors: messages.errors));
      } catch (e) {
        return left(ServerFailure(errors: {'error': e.toString()}));
      }
    } else {
      return left(OfflineFailure());
    }
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

  @override
  Future<Either<Failure, Unit>> updateClosingAccount(
      ClosingAccountEntity closingAccountEntity) async {
    ClosingAccountModel closingAccountModel = ClosingAccountModel(
        id: closingAccountEntity.id,
        arName: closingAccountEntity.arName,
        enName: closingAccountEntity.enName,
        createdAt: closingAccountEntity.createdAt,
        updatedAt: closingAccountEntity.updatedAt);

    if (await networkInfo.isConnected) {
      try {
        await closingAccountDataSource
            .updateClosingAccounts(closingAccountModel);

        return right(unit);
      } on ValidationException catch (messages) {
        return left(ValidationFailure(errors: messages.errors));
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, ClosingAccountEntity>> showClosingAccount(
      int accountId, String? direction) async {
    if (await networkInfo.isConnected) {
      try {
        final closingAccounts = await closingAccountDataSource
            .showClosingAccount(accountId, direction);

        return right(closingAccounts);
      } on ServerException {
        return left(ServerFailure());
      } catch (e) {
        return left(ServerFailure(errors: {'error': e.toString()}));
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
