import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/repositories/adjustment_note_repository.dart';

class ShowAdjustmentNoteUseCase {
  final AdjustmentNoteRepository invoiceRepository;

  ShowAdjustmentNoteUseCase({required this.invoiceRepository});

  Future<Either<Failure, AdjustmentNoteEntity>> call(
      int invoiceQuery, String? direction, String type, String? getBy) async {
    return await invoiceRepository.showAdjustmentNote(invoiceQuery, direction, type,getBy);
  }
}
