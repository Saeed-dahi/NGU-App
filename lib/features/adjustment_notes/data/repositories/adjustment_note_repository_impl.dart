import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/features/adjustment_notes/data/data_sources/adjustemnt_note_data_source.dart';
import 'package:ngu_app/features/adjustment_notes/data/models/params/adjustment_note_items_model_params.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/params/adjustment_note_items_entity_params.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/params/preview_adjustment_note_item_entity_params.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/preview_adjustment_note_item_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/repositories/adjustment_note_repository.dart';

class AdjustmentNoteRepositoryImpl implements AdjustmentNoteRepository {
  final ApiHelper apiHelper;
  final AdjustmentNoteDataSource invoiceDataSource;

  AdjustmentNoteRepositoryImpl(
      {required this.apiHelper, required this.invoiceDataSource});

  @override
  Future<Either<Failure, List<AdjustmentNoteEntity>>> getAllAdjustmentNote(
      String type) async {
    return await apiHelper
        .safeApiCall(() => invoiceDataSource.getAllAdjustmentNotes(type));
  }

  @override
  Future<Either<Failure, AdjustmentNoteEntity>> showAdjustmentNote(
      int invoiceQuery, String? direction, String type, String? getBy) async {
    return await apiHelper.safeApiCall(() => invoiceDataSource
        .showAdjustmentNote(invoiceQuery, direction, type, getBy ?? 'id'));
  }

  @override
  Future<Either<Failure, AdjustmentNoteEntity>> createAdjustmentNote(
      AdjustmentNoteEntity invoiceEntity,
      List<AdjustmentNoteItemsEntityParams> items) async {
    return await apiHelper.safeApiCall(() => invoiceDataSource
        .createAdjustmentNote(invoiceEntity.toModel(), _getItemsModel(items)));
  }

  @override
  Future<Either<Failure, AdjustmentNoteEntity>> updateAdjustmentNote(
      AdjustmentNoteEntity invoiceEntity,
      List<AdjustmentNoteItemsEntityParams> items) async {
    return await apiHelper.safeApiCall(() => invoiceDataSource
        .updateAdjustmentNote(invoiceEntity.toModel(), _getItemsModel(items)));
  }

  @override
  Future<Either<Failure, AdjustmentNoteEntity>> getCreateAdjustmentNoteFormData(
      String type) async {
    return await apiHelper.safeApiCall(
        () => invoiceDataSource.getCreateAdjustmentNoteFormData(type));
  }

  @override
  Future<Either<Failure, PreviewAdjustmentNoteItemEntity>>
      previewAdjustmentNoteItem(
          PreviewAdjustmentNoteItemEntityParams params) async {
    return await apiHelper.safeApiCall(
        () => invoiceDataSource.previewAdjustmentNoteItem(params.toModel()));
  }

  List<AdjustmentNoteItemsModelParams> _getItemsModel(
      List<AdjustmentNoteItemsEntityParams> items) {
    return items.map((item) {
      return item.toModel();
    }).toList();
  }
}
