import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';
import 'package:ngu_app/features/cheques/domain/repositories/cheque_repository.dart';

class GetChequesPerAccountUseCase {
  final ChequeRepository chequeRepository;

  GetChequesPerAccountUseCase({required this.chequeRepository});

  Future<Either<Failure, List<ChequeEntity>>> call(int accountId) async {
    return chequeRepository.getChequesPerAccount(accountId);
  }
}
