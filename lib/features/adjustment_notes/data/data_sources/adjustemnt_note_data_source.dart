import 'dart:convert';

import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/core/error/error_handler.dart';
import 'package:ngu_app/core/network/network_connection.dart';
import 'package:ngu_app/features/adjustment_notes/data/models/adjustment_note_model.dart';
import 'package:ngu_app/features/adjustment_notes/data/models/params/adjustment_note_items_model_params.dart';
import 'package:ngu_app/features/adjustment_notes/data/models/params/preview_adjustment_note_item_model_params.dart';
import 'package:ngu_app/features/adjustment_notes/data/models/preview_adjustment_note_item_model.dart';

abstract class AdjustmentNoteDataSource {
  Future<List<AdjustmentNoteModel>> getAllAdjustmentNotes(String type);
  Future<AdjustmentNoteModel> showAdjustmentNote(
      int invoiceQuery, String? direction, String type, String? getBy);
  Future<AdjustmentNoteModel> createAdjustmentNote(
      AdjustmentNoteModel adjustmentNoteModel,
      List<AdjustmentNoteItemsModelParams> items);
  Future<AdjustmentNoteModel> updateAdjustmentNote(
      AdjustmentNoteModel adjustmentNoteModel,
      List<AdjustmentNoteItemsModelParams> items);

  Future<AdjustmentNoteModel> getCreateAdjustmentNoteFormData(String type);

  Future<PreviewAdjustmentNoteItemModel> previewAdjustmentNoteItem(
      PreviewAdjustmentNoteItemModelParams params);
}

class AdjustmentNoteDataSourceImpl implements AdjustmentNoteDataSource {
  final NetworkConnection networkConnection;

  AdjustmentNoteDataSourceImpl({required this.networkConnection});

  @override
  Future<List<AdjustmentNoteModel>> getAllAdjustmentNotes(String type) async {
    final response =
        await networkConnection.get(APIList.adjustmentNote, {'type': type});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    List<AdjustmentNoteModel> invoices = decodedJson['data']
        .map<AdjustmentNoteModel>(
            (invoice) => AdjustmentNoteModel.fromJson(invoice))
        .toList();

    return invoices;
  }

  @override
  Future<AdjustmentNoteModel> showAdjustmentNote(
      int invoiceId, String? direction, String type, String? getBy) async {
    final response = await networkConnection.get(
        '${APIList.adjustmentNote}/$invoiceId',
        {'direction': direction, 'type': type, 'get_by': getBy});
    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    AdjustmentNoteModel invoice =
        AdjustmentNoteModel.fromJson(decodedJson['data']);

    return invoice;
  }

  @override
  Future<AdjustmentNoteModel> createAdjustmentNote(
      AdjustmentNoteModel adjustmentNoteModel,
      List<AdjustmentNoteItemsModelParams> items) async {
    final response = await networkConnection.post(APIList.adjustmentNote, {
      'adjustment_note': adjustmentNoteModel.toJson(),
      'items': items.map((item) => item.toJson()).toList()
    });
    var decodedJson = jsonDecode(response.body);
    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    AdjustmentNoteModel invoice =
        AdjustmentNoteModel.fromJson(decodedJson['data']);

    return invoice;
  }

  @override
  Future<AdjustmentNoteModel> updateAdjustmentNote(
      AdjustmentNoteModel adjustmentNoteModel,
      List<AdjustmentNoteItemsModelParams> items) async {
    final response = await networkConnection
        .put('${APIList.adjustmentNote}/${adjustmentNoteModel.id}', {
      'adjustment_note': adjustmentNoteModel.toJson(),
      'items': items.map((item) => item.toJson()).toList()
    });

    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    AdjustmentNoteModel invoice =
        AdjustmentNoteModel.fromJson(decodedJson['data']);

    return invoice;
  }

  @override
  Future<AdjustmentNoteModel> getCreateAdjustmentNoteFormData(
      String type) async {
    final response = await networkConnection
        .get('${APIList.adjustmentNote}/create', {'type': type});

    var decodedJson = jsonDecode(response.body);

    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    AdjustmentNoteModel invoice =
        AdjustmentNoteModel.fromJson(decodedJson['data']);

    return invoice;
  }

  @override
  Future<PreviewAdjustmentNoteItemModel> previewAdjustmentNoteItem(
      PreviewAdjustmentNoteItemModelParams params) async {
    final response = await networkConnection.get(
        APIList.previewAdjustmentNoteItem, params.toJson());
    var decodedJson = jsonDecode(response.body);
    ErrorHandler.handleResponse(response.statusCode, decodedJson);

    PreviewAdjustmentNoteItemModel invoiceItem =
        PreviewAdjustmentNoteItemModel.toJson(decodedJson['data']);

    return invoiceItem;
  }
}
