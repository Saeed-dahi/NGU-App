import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/cubit/pluto_grid_cubit.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_account_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_item_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_product_unit_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/params/preview_invoice_item_entity_params.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/preview_invoice_item_entity.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_bloc/invoice_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_form_cubit/invoice_form_cubit.dart';
import 'package:ngu_app/features/inventory/products/presentation/pages/products_table.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

part 'preview_invoice_item_state.dart';

class PreviewInvoiceItemCubit extends Cubit<PreviewInvoiceItemState> {
  PreviewInvoiceItemCubit() : super(PreviewInvoiceItemInitial());

  Future<Map<String, dynamic>> _openProductsDialog(
      BuildContext context, String query) async {
    final result = await ShowDialog.showCustomDialog(
      context: context,
      content: ProductsTable(
        localeSearchQuery: query,
      ),
    );
    return result ?? {};
  }

  Future<void> onColumnChange(
      BuildContext context,
      PlutoGridOnChangedEvent onChangeEvent,
      PlutoGridStateManager? stateManager) async {
    final row = onChangeEvent.row;
    String query = onChangeEvent.value;
    InvoiceProductUnitEntity? productUnit = row.data?.productUnit;
    PreviewInvoiceItemEntity? previewInvoiceItem;

    previewInvoiceItem = await _handleColumnChange(
        context, onChangeEvent, query, row, productUnit);

    if (previewInvoiceItem == null) return;

    // Update the invoice item and grid
    _updateUiAfterColumnChange(row, previewInvoiceItem, stateManager);

    context.mounted ? context.read<PlutoGridCubit>().onChangeFunction() : ();
  }

  void _updateUiAfterColumnChange(
      PlutoRow<dynamic> row,
      PreviewInvoiceItemEntity previewInvoiceItem,
      PlutoGridStateManager? stateManager) {
    InvoiceItemEntity updatedInvoiceItem =
        _updateInvoiceItemEntity(row, previewInvoiceItem);
    row.data = updatedInvoiceItem;

    final updates = _generateUpdateMap(updatedInvoiceItem, previewInvoiceItem);

    // Apply updates to the grid
    _updateGridCells(row, updates);

    stateManager?.notifyListeners();
  }

  /// Handles column-specific changes
  Future<PreviewInvoiceItemEntity?> _handleColumnChange(
      BuildContext context,
      PlutoGridOnChangedEvent onChangeEvent,
      String query,
      PlutoRow row,
      InvoiceProductUnitEntity? productUnit) async {
    switch (onChangeEvent.column.field) {
      case 'code':
        return await _handleCodeColumnChange(context, query, row);

      default:
        return productUnit != null
            ? await _previewInvoiceItem(
                context: context,
                query: productUnit.product!.code.toString(),
                productUnitId: productUnit.unit!.id,
                row: row,
              )
            : null;
    }
  }

  /// Handles changes when the "code" column is updated
  Future<PreviewInvoiceItemEntity?> _handleCodeColumnChange(
      BuildContext context, String query, PlutoRow row) async {
    var previewInvoiceItem =
        await _previewInvoiceItem(context: context, query: query, row: row);

    if (previewInvoiceItem == null && context.mounted) {
      final result = await _openProductsDialog(context, query);
      if (result.isNotEmpty && context.mounted) {
        query = result['code'];
        previewInvoiceItem =
            await _previewInvoiceItem(context: context, query: query, row: row);
      }
    }

    return previewInvoiceItem;
  }

  /// Handles changes when the "unit" column is updated
  Future<PreviewInvoiceItemEntity?> handleUnitColumnChange(
      BuildContext context, PlutoGridStateManager? stateManager) async {
    InvoiceProductUnitEntity productUnit =
        stateManager!.currentRow!.data.productUnit;
    PlutoRow? row = stateManager.currentRow;
    PreviewInvoiceItemEntity? previewInvoiceItem = await _previewInvoiceItem(
        context: context,
        query: productUnit.product!.code.toString(),
        productUnitId: productUnit.unit!.id,
        row: row!,
        changeUnit: true);
    if (previewInvoiceItem != null) {
      _updateUiAfterColumnChange(row, previewInvoiceItem, stateManager);
    }
    return null;
  }

  /// Generates a map of updates for the grid cells
  Map<String, dynamic> _generateUpdateMap(InvoiceItemEntity updatedInvoiceItem,
      PreviewInvoiceItemEntity previewInvoiceItem) {
    return {
      'code': updatedInvoiceItem.productUnit?.product?.code,
      'name': updatedInvoiceItem.productUnit?.product?.arName,
      'quantity': updatedInvoiceItem.quantity,
      'unit': updatedInvoiceItem.productUnit?.unit?.arName,
      'price': updatedInvoiceItem.price,
      'sub_total': previewInvoiceItem.productUnit.subTotal,
      'tax_amount': updatedInvoiceItem.taxAmount,
      'total':
          (updatedInvoiceItem.total ?? 0) + (updatedInvoiceItem.taxAmount ?? 0),
      'notes': updatedInvoiceItem.description,
    };
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

    final data = await context.read<InvoiceBloc>().previewInvoiceItem(params);
    return data;
  }

  InvoiceItemEntity _updateInvoiceItemEntity(
      PlutoRow<dynamic> row, PreviewInvoiceItemEntity previewInvoiceItem) {
    InvoiceItemEntity currentInvoiceItem =
        row.data ?? const InvoiceItemEntity();
    InvoiceProductUnitEntity productUnit =
        currentInvoiceItem.productUnit ?? const InvoiceProductUnitEntity();
    InvoiceProductEntity product =
        productUnit.product ?? const InvoiceProductEntity();
    InvoiceUnitEntity unit = productUnit.unit ?? const InvoiceUnitEntity();

    // Update product and unit details
    final updatedProduct = product.copyWith(
      id: previewInvoiceItem.id,
      arName: previewInvoiceItem.arName,
      enName: previewInvoiceItem.enName,
      code: previewInvoiceItem.code,
    );

    final updatedUnit = unit.copyWith(
      id: previewInvoiceItem.productUnit.unitId,
      arName: previewInvoiceItem.productUnit.arName,
      enName: previewInvoiceItem.productUnit.enName,
    );

    final updatedProductUnit = productUnit.copyWith(
      id: previewInvoiceItem.productUnit.id,
      product: updatedProduct,
      unit: updatedUnit,
    );

    // Update invoice item
    final updatedInvoiceItem = currentInvoiceItem.copyWith(
      price: previewInvoiceItem.productUnit.price,
      quantity: double.tryParse(row.cells['quantity']!.value.toString()) ?? 1,
      taxAmount: previewInvoiceItem.productUnit.taxAmount,
      total: previewInvoiceItem.productUnit.total,
      description: '',
      productUnit: updatedProductUnit,
    );
    return updatedInvoiceItem;
  }

  void _updateGridCells(PlutoRow<dynamic> row, Map<String, dynamic> updates) {
    for (var entry in updates.entries) {
      updateCurrentCell(row, entry.key, entry.value);
    }
  }

  updateCurrentCell(PlutoRow<dynamic> row, String cell, dynamic value) {
    row.cells[cell]!.value = value;
  }
}
