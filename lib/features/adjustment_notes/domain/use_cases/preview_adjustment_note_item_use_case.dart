import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/params/preview_adjustment_note_item_entity_params.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/preview_adjustment_note_item_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/repositories/adjustment_note_repository.dart';

class PreviewAdjustmentNoteItemUseCase {
  final AdjustmentNoteRepository invoiceRepository;

  PreviewAdjustmentNoteItemUseCase({required this.invoiceRepository});

  Future<Either<Failure, PreviewAdjustmentNoteItemEntity>> call(
      PreviewAdjustmentNoteItemEntityParams params) async {
    return invoiceRepository.previewAdjustmentNoteItem(params);
  }
}
