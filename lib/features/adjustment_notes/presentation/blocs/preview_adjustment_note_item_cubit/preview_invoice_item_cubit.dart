import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/snack_bar.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/cubit/pluto_grid_cubit.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_account_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_item_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_product_unit_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/params/preview_adjustment_note_item_entity_params.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/preview_adjustment_note_item_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/use_cases/preview_adjustment_note_item_use_case.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_form_cubit/adjustment_note_form_cubit.dart';

import 'package:ngu_app/features/inventory/products/presentation/pages/products_table.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';
part 'preview_invoice_item_state.dart';

class PreviewAdjustmentNoteItemCubit
    extends Cubit<PreviewAdjustmentNoteItemState> {
  final PreviewAdjustmentNoteItemUseCase previewAdjustmentNoteItemUseCase;
  late PlutoGridOnChangedEvent onChangeEvent;
  late PlutoRow row;
  late String query;
  set setOnChangeEvent(PlutoGridOnChangedEvent onChangeEvent) {
    this.onChangeEvent = onChangeEvent;
    row = onChangeEvent.row;
    query = onChangeEvent.value;
  }

  PreviewAdjustmentNoteItemCubit(this.previewAdjustmentNoteItemUseCase)
      : super(PreviewAdjustmentNoteItemInitial());

  Future<void> onColumnChange(
      BuildContext context, PlutoGridStateManager? stateManager) async {
    PreviewAdjustmentNoteItemEntity? previewAdjustmentNoteItem;

    previewAdjustmentNoteItem = await _handleColumnChange(context);

    if (previewAdjustmentNoteItem == null) return;

    // Update the invoice item and grid
    _updateUiAfterColumnChange(row, previewAdjustmentNoteItem, stateManager);

    context.mounted ? context.read<PlutoGridCubit>().onChangeFunction() : ();
  }

  /// Handles column-specific changes
  Future<PreviewAdjustmentNoteItemEntity?> _handleColumnChange(
    BuildContext context,
  ) async {
    PreviewAdjustmentNoteItemEntity? previewAdjustmentNoteItem = row.data;

    switch (onChangeEvent.column.field) {
      case 'code':
        return await _handleCodeColumnChange(context);
      default:
        return await _handleDefaultColumnChange(previewAdjustmentNoteItem, context);
    }
  }

  /// Handles changes when the "code" column is updated
  Future<PreviewAdjustmentNoteItemEntity?> _handleCodeColumnChange(
      BuildContext context) async {
    var previewAdjustmentNoteItem =
        await _previewAdjustmentNoteItem(context: context, query: query, row: row);

    if (previewAdjustmentNoteItem == null && context.mounted) {
      final result = await _openProductsDialog(context);
      if (result.isNotEmpty && context.mounted) {
        query = result['code'];
        previewAdjustmentNoteItem =
            await _previewAdjustmentNoteItem(context: context, query: query, row: row);
      }
    }
    return previewAdjustmentNoteItem;
  }

  Future<Map<String, dynamic>> _openProductsDialog(BuildContext context) async {
    final result = await ShowDialog.showCustomDialog(
      context: context,
      content: ProductsTable(
        localeSearchQuery: query,
      ),
    );
    return result ?? {};
  }

  /// Handles changes when the "any" column is updated
  Future<PreviewAdjustmentNoteItemEntity?> _handleDefaultColumnChange(
      PreviewAdjustmentNoteItemEntity? previewAdjustmentNoteItem,
      BuildContext context) async {
    // return null if there is no preview item so you should add first
    return previewAdjustmentNoteItem != null
        ? await _previewAdjustmentNoteItem(
            context: context,
            query: previewAdjustmentNoteItem.code.toString(),
            productUnitId: previewAdjustmentNoteItem.productUnit.id,
            row: row,
          )
        : null;
  }

  // Handles changes when the "unit" column is updated
  Future<void> handleUnitColumnChange(
      BuildContext context, PlutoGridStateManager? stateManager) async {
    PlutoRow? row = stateManager!.currentRow;
    PreviewAdjustmentNoteItemEntity currentAdjustmentNoteItem = row!.data;
    PreviewAdjustmentNoteItemEntity? previewAdjustmentNoteItem = await _previewAdjustmentNoteItem(
        context: context,
        query: currentAdjustmentNoteItem.code.toString(),
        productUnitId: currentAdjustmentNoteItem.productUnit.id,
        row: row,
        changeUnit: true);
    if (previewAdjustmentNoteItem != null) {
      _updateUiAfterColumnChange(row, previewAdjustmentNoteItem, stateManager);
    }
  }

  Future<PreviewAdjustmentNoteItemEntity?> _previewAdjustmentNoteItem({
    required BuildContext context,
    required String query,
    required PlutoRow<dynamic> row,
    int? productUnitId,
    double? price,
    bool? changeUnit,
  }) async {
    AdjustmentNoteAccountEntity? account =
        context.read<AdjustmentNoteFormCubit>().accountController;

    PreviewAdjustmentNoteItemEntityParams params = PreviewAdjustmentNoteItemEntityParams(
        query: query,
        accountId: account.id,
        productUnitId: productUnitId,
        price: price ?? double.tryParse(row.cells['price']!.value.toString()),
        quantity: double.tryParse(row.cells['quantity']!.value.toString()),
        changeUnit: changeUnit);

    final data = await previewAdjustmentNoteItem(params);
    return data;
  }

  void _updateUiAfterColumnChange(
      PlutoRow<dynamic> row,
      PreviewAdjustmentNoteItemEntity previewAdjustmentNoteItem,
      PlutoGridStateManager? stateManager) {
    row.data = previewAdjustmentNoteItem;

    final updates = _generateUpdateMap(previewAdjustmentNoteItem, row);

    // Apply updates to the grid
    _updateGridCells(row, updates);

    stateManager?.notifyListeners();
  }

  /// Generates a map of updates for the grid cells
  Map<String, dynamic> _generateUpdateMap(
      PreviewAdjustmentNoteItemEntity previewAdjustmentNoteItem, PlutoRow<dynamic> row) {
    var currentQuantity = row.cells['quantity']!.value;
    return {
      'code': previewAdjustmentNoteItem.code,
      'name': previewAdjustmentNoteItem.arName,
      'unit': previewAdjustmentNoteItem.productUnit.arName,
      'quantity': currentQuantity != '' ? currentQuantity : 1,
      'price': previewAdjustmentNoteItem.productUnit.price,
      'sub_total': previewAdjustmentNoteItem.productUnit.subTotal,
      'tax_amount': previewAdjustmentNoteItem.productUnit.taxAmount,
      'total': previewAdjustmentNoteItem.productUnit.total,
    };
  }

  void _updateGridCells(PlutoRow<dynamic> row, Map<String, dynamic> updates) {
    for (var entry in updates.entries) {
      updateCurrentCell(row, entry.key, entry.value);
    }
  }

  updateCurrentCell(PlutoRow<dynamic> row, String cell, dynamic value) {
    row.cells[cell]!.value = value;
  }

  PreviewAdjustmentNoteItemEntity invoiceItemToPreviewAdjustmentNoteItem(
      AdjustmentNoteProductEntity? product,
      AdjustmentNoteItemEntity invoiceItem,
      AdjustmentNoteUnitEntity? unit) {
    PreviewAdjustmentNoteItemEntity previewAdjustmentNoteItem = PreviewAdjustmentNoteItemEntity(
        id: product!.id!,
        arName: product.arName!,
        enName: product.enName!,
        code: product.code!,
        productUnit: PreviewProductUnitEntity(
            id: invoiceItem.productUnit!.id!,
            arName: unit!.arName!,
            enName: unit.enName!,
            unitId: unit.id!,
            price: invoiceItem.price!,
            taxAmount: invoiceItem.taxAmount!,
            subTotal: invoiceItem.total!,
            total: invoiceItem.total! + invoiceItem.taxAmount!));
    return previewAdjustmentNoteItem;
  }

  Future<PreviewAdjustmentNoteItemEntity?> previewAdjustmentNoteItem(
      PreviewAdjustmentNoteItemEntityParams params) async {
    PreviewAdjustmentNoteItemEntity? previewAdjustmentNoteItem;
    final result = await previewAdjustmentNoteItemUseCase(params);

    result.fold(
      (failure) {
        ShowSnackBar.showValidationSnackbar(
            messages: [failure.errors.values.toString()]);
      },
      (data) {
        previewAdjustmentNoteItem = data;
      },
    );
    return previewAdjustmentNoteItem;
  }
}
