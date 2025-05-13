import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';
import 'package:ngu_app/features/cheques/domain/entities/params/multiple_cheques_params_entity.dart';
import 'package:ngu_app/features/cheques/domain/repositories/cheque_repository.dart';

class CreateMultipleChequesUseCase {
  final ChequeRepository chequeRepository;

  CreateMultipleChequesUseCase({required this.chequeRepository});
  Future<Either<Failure, bool>> call(ChequeEntity cheque,
      MultipleChequesParamsEntity multipleChequesParamsEntity) async {
    return await chequeRepository.createMultipleCheques(
        cheque, multipleChequesParamsEntity);
  }
}
