import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/params/adjustment_note_items_entity_params.dart';
import 'package:ngu_app/features/adjustment_notes/domain/repositories/adjustment_note_repository.dart';

class UpdateAdjustmentNoteUseCase {
  final AdjustmentNoteRepository invoiceRepository;

  UpdateAdjustmentNoteUseCase({required this.invoiceRepository});

  Future<Either<Failure, AdjustmentNoteEntity>> call(
      AdjustmentNoteEntity invoice, List<AdjustmentNoteItemsEntityParams> items) async {
    return await invoiceRepository.updateAdjustmentNote(invoice, items);
  }
}
