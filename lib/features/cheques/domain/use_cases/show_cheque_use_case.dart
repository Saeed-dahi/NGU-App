import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';
import 'package:ngu_app/features/cheques/domain/repositories/cheque_repository.dart';

class ShowChequeUseCase {
  final ChequeRepository chequeRepository;

  ShowChequeUseCase({required this.chequeRepository});

  Future<Either<Failure, ChequeEntity>> call(int id, String? direction) async {
    return await chequeRepository.showCheque(id, direction);
  }
}
