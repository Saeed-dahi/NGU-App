import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/snack_bar.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/cubit/pluto_grid_cubit.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_account_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_item_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_product_unit_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/params/preview_invoice_item_entity_params.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/preview_invoice_item_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/preview_invoice_item_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_form_cubit/invoice_form_cubit.dart';
import 'package:ngu_app/features/inventory/products/presentation/pages/products_table.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';
part 'preview_invoice_item_state.dart';

class PreviewInvoiceItemCubit extends Cubit<PreviewInvoiceItemState> {
  final PreviewInvoiceItemUseCase previewInvoiceItemUseCase;
  late PlutoGridOnChangedEvent onChangeEvent;
  late PlutoRow row;
  late String query;
  set setOnChangeEvent(PlutoGridOnChangedEvent onChangeEvent) {
    this.onChangeEvent = onChangeEvent;
    row = onChangeEvent.row;
    query = onChangeEvent.value;
  }

  PreviewInvoiceItemCubit(this.previewInvoiceItemUseCase)
      : super(PreviewInvoiceItemInitial());

  Future<void> onColumnChange(
      BuildContext context, PlutoGridStateManager? stateManager) async {
    PreviewInvoiceItemEntity? previewInvoiceItem;

    previewInvoiceItem = await _handleColumnChange(context);

    if (previewInvoiceItem == null) return;

    // Update the invoice item and grid
    _updateUiAfterColumnChange(row, previewInvoiceItem, stateManager);

    context.mounted ? context.read<PlutoGridCubit>().onChangeFunction() : ();
  }

  /// Handles column-specific changes
  Future<PreviewInvoiceItemEntity?> _handleColumnChange(
    BuildContext context,
  ) async {
    PreviewInvoiceItemEntity? previewInvoiceItem = row.data;

    switch (onChangeEvent.column.field) {
      case 'code':
        return await _handleCodeColumnChange(context);
      default:
        return await _handleDefaultColumnChange(previewInvoiceItem, context);
    }
  }

  /// Handles changes when the "code" column is updated
  Future<PreviewInvoiceItemEntity?> _handleCodeColumnChange(
      BuildContext context) async {
    var previewInvoiceItem =
        await _previewInvoiceItem(context: context, query: query, row: row);

    if (previewInvoiceItem == null && context.mounted) {
      final result = await _openProductsDialog(context);
      if (result.isNotEmpty && context.mounted) {
        query = result['code'];
        previewInvoiceItem =
            await _previewInvoiceItem(context: context, query: query, row: row);
      }
    }
    return previewInvoiceItem;
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
  Future<PreviewInvoiceItemEntity?> _handleDefaultColumnChange(
      PreviewInvoiceItemEntity? previewInvoiceItem,
      BuildContext context) async {
    // return null if there is no preview item so you should add first
    return previewInvoiceItem != null
        ? await _previewInvoiceItem(
            context: context,
            query: previewInvoiceItem.code.toString(),
            productUnitId: previewInvoiceItem.productUnit.id,
            row: row,
          )
        : null;
  }

  // Handles changes when the "unit" column is updated
  Future<void> handleUnitColumnChange(
      BuildContext context, PlutoGridStateManager? stateManager) async {
    PlutoRow? row = stateManager!.currentRow;
    PreviewInvoiceItemEntity currentInvoiceItem = row!.data;
    PreviewInvoiceItemEntity? previewInvoiceItem = await _previewInvoiceItem(
        context: context,
        query: currentInvoiceItem.code.toString(),
        productUnitId: currentInvoiceItem.productUnit.id,
        row: row,
        changeUnit: true);
    if (previewInvoiceItem != null) {
      _updateUiAfterColumnChange(row, previewInvoiceItem, stateManager);
    }
  }

  Future<PreviewInvoiceItemEntity?> _previewInvoiceItem({
    required BuildContext context,
    required String query,
    required PlutoRow<dynamic> row,
    int? productUnitId,
    double? price,
    bool? changeUnit,
  }) async {
    InvoiceAccountEntity? account =
        context.read<InvoiceFormCubit>().accountController;

    PreviewInvoiceItemEntityParams params = PreviewInvoiceItemEntityParams(
        query: query,
        accountId: account.id,
        productUnitId: productUnitId,
        price: price ?? double.tryParse(row.cells['price']!.value.toString()),
        quantity: double.tryParse(row.cells['quantity']!.value.toString()),
        changeUnit: changeUnit);

    final data = await previewInvoiceItem(params);
    return data;
  }

  void _updateUiAfterColumnChange(
      PlutoRow<dynamic> row,
      PreviewInvoiceItemEntity previewInvoiceItem,
      PlutoGridStateManager? stateManager) {
    row.data = previewInvoiceItem;

    final updates = _generateUpdateMap(previewInvoiceItem, row);

    // Apply updates to the grid
    _updateGridCells(row, updates);

    stateManager?.notifyListeners();
  }

  /// Generates a map of updates for the grid cells
  Map<String, dynamic> _generateUpdateMap(
      PreviewInvoiceItemEntity previewInvoiceItem, PlutoRow<dynamic> row) {
    var currentQuantity = row.cells['quantity']!.value;
    return {
      'code': previewInvoiceItem.code,
      'name': previewInvoiceItem.arName,
      'unit': previewInvoiceItem.productUnit.arName,
      'quantity': currentQuantity != '' ? currentQuantity : 1,
      'price': previewInvoiceItem.productUnit.price,
      'sub_total': previewInvoiceItem.productUnit.subTotal,
      'tax_amount': previewInvoiceItem.productUnit.taxAmount,
      'total': previewInvoiceItem.productUnit.total,
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

  PreviewInvoiceItemEntity invoiceItemToPreviewInvoiceItem(
      InvoiceProductEntity? product,
      InvoiceItemEntity invoiceItem,
      InvoiceUnitEntity? unit) {
    PreviewInvoiceItemEntity previewInvoiceItem = PreviewInvoiceItemEntity(
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
    return previewInvoiceItem;
  }

  Future<PreviewInvoiceItemEntity?> previewInvoiceItem(
      PreviewInvoiceItemEntityParams params) async {
    PreviewInvoiceItemEntity? previewInvoiceItem;
    final result = await previewInvoiceItemUseCase(params);

    result.fold(
      (failure) {
        ShowSnackBar.showValidationSnackbar(
            messages: [failure.errors.values.toString()]);
      },
      (data) {
        previewInvoiceItem = data;
      },
    );
    return previewInvoiceItem;
  }
}
