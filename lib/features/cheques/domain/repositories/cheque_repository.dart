import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';

abstract class ChequeRepository {
  Future<Either<Failure, ChequeEntity>> showCheque(int id, String? direction);
  Future<Either<Failure, List<ChequeEntity>>> getAllCheques();
  Future<Either<Failure, ChequeEntity>> createCheque(ChequeEntity cheque);
  Future<Either<Failure, ChequeEntity>> updateCheque(ChequeEntity cheque);
  Future<Either<Failure, ChequeEntity>> depositCheque(int id);
  Future<Either<Failure, List<ChequeEntity>>> getChequesPerAccount(int accountId);
}
