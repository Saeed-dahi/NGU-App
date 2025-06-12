import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/params/adjustment_note_items_entity_params.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/params/preview_adjustment_note_item_entity_params.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/preview_adjustment_note_item_entity.dart';

abstract class AdjustmentNoteRepository {
  Future<Either<Failure, List<AdjustmentNoteEntity>>> getAllAdjustmentNote(
      String type);
  Future<Either<Failure, AdjustmentNoteEntity>> showAdjustmentNote(
      int adjustmentNoteQuery, String? direction, String type, String? getBy);

  Future<Either<Failure, AdjustmentNoteEntity>> createAdjustmentNote(
      AdjustmentNoteEntity adjustmentNoteEntity,
      List<AdjustmentNoteItemsEntityParams> items);
  Future<Either<Failure, AdjustmentNoteEntity>> updateAdjustmentNote(
      AdjustmentNoteEntity adjustmentNoteEntity,
      List<AdjustmentNoteItemsEntityParams> items);

  Future<Either<Failure, AdjustmentNoteEntity>> getCreateAdjustmentNoteFormData(
      String type);

  Future<Either<Failure, PreviewAdjustmentNoteItemEntity>>
      previewAdjustmentNoteItem(PreviewAdjustmentNoteItemEntityParams params);
}
