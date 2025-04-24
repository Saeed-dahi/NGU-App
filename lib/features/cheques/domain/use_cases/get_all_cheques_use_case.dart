import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';
import 'package:ngu_app/features/cheques/domain/repositories/cheque_repository.dart';

class GetAllChequesUseCase {
  final ChequeRepository chequeRepository;

  GetAllChequesUseCase({required this.chequeRepository});

  Future<Either<Failure, List<ChequeEntity>>> call() async {
    return chequeRepository.getAllCheques();
  }
}
