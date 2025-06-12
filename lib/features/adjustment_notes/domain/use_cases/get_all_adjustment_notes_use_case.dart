import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/repositories/adjustment_note_repository.dart';

class GetAllAdjustmentNotesUseCase {
  final AdjustmentNoteRepository invoiceRepository;

  GetAllAdjustmentNotesUseCase({required this.invoiceRepository});

  Future<Either<Failure, List<AdjustmentNoteEntity>>> call(String type) async {
    return await invoiceRepository.getAllAdjustmentNote(type);
  }
}
