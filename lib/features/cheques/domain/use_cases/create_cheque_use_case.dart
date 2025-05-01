import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/features/upload/domain/entities/file_upload_entity.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';
import 'package:ngu_app/features/cheques/domain/repositories/cheque_repository.dart';

class CreateChequeUseCase {
  final ChequeRepository chequeRepository;

  CreateChequeUseCase({required this.chequeRepository});

  Future<Either<Failure, ChequeEntity>> call(
      ChequeEntity cheque, FileUploadEntity files) async {
    return await chequeRepository.createCheque(cheque,files);
  }
}
