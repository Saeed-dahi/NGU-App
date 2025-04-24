import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';
import 'package:ngu_app/features/cheques/domain/repositories/cheque_repository.dart';

class DepositChequeUseCase {
  final ChequeRepository chequeRepository;

  DepositChequeUseCase({required this.chequeRepository});

  Future<Either<Failure, ChequeEntity>> call(int id) async {
    return await chequeRepository.depositCheque(id);
  }
}
