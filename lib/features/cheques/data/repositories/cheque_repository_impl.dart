import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/features/cheques/data/data_sources/cheque_data_source.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';
import 'package:ngu_app/features/cheques/domain/repositories/cheque_repository.dart';

class ChequeRepositoryImpl implements ChequeRepository {
  final ApiHelper apiHelper;
  final ChequeDataSource chequeDataSource;

  ChequeRepositoryImpl(
      {required this.apiHelper, required this.chequeDataSource});

  @override
  Future<Either<Failure, ChequeEntity>> showCheque(
      int id, String? direction) async {
    return await apiHelper
        .safeApiCall(() => chequeDataSource.showCheque(id, direction));
  }

  @override
  Future<Either<Failure, List<ChequeEntity>>> getAllCheques() async {
    return apiHelper.safeApiCall(() => chequeDataSource.getAllCheques());
  }

  @override
  Future<Either<Failure, ChequeEntity>> createCheque(
      ChequeEntity cheque) async {
    return await apiHelper
        .safeApiCall(() => chequeDataSource.createCheque(cheque.toModel()));
  }

  @override
  Future<Either<Failure, ChequeEntity>> updateCheque(
      ChequeEntity cheque) async {
    return await apiHelper
        .safeApiCall(() => chequeDataSource.updateCheque(cheque.toModel()));
  }

  @override
  Future<Either<Failure, ChequeEntity>> depositCheque(int id) async {
    return await apiHelper
        .safeApiCall(() => chequeDataSource.depositCheque(id));
  }
}
