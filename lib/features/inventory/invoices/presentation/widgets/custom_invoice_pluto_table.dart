import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_account_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_item_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_product_unit_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/preview_invoice_item_entity.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_bloc/invoice_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_form_cubit/invoice_form_cubit.dart';
import 'package:ngu_app/features/inventory/products/presentation/pages/products_table.dart';
import 'package:ngu_app/features/inventory/units/presentation/pages/units_table.dart';

import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomInvoicePlutoTable extends StatelessWidget {
  final InvoiceEntity? invoice;
  final bool readOnly;

  CustomInvoicePlutoTable({super.key, this.invoice, this.readOnly = false});

  late PlutoGridController _plutoGridController = PlutoGridController();

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

  Future<Map<String, dynamic>> _openProductUnitsDialog(
      BuildContext context, int productId) async {
    final result = await ShowDialog.showCustomDialog(
      context: context,
      content: UnitsTable(
        productId: productId,
        showProductUnits: true,
      ),
    );
    return result ?? {};
  }

  Future<void> _onChange(
      BuildContext context, PlutoGridOnChangedEvent onChangeEvent) async {
    final row = onChangeEvent.row;
    String query = onChangeEvent.value;
    InvoiceProductUnitEntity? productUnit = row.data?.productUnit;

    PreviewInvoiceItemEntity? previewInvoiceItem;

    switch (onChangeEvent.column.field) {
      case 'code':
        previewInvoiceItem = await _previewInvoiceItem(context, query);
        if (previewInvoiceItem == null) {
          final result = await _openProductsDialog(context, query);
          if (result.isNotEmpty) {
            query = result['code'];
            previewInvoiceItem = await _previewInvoiceItem(context, query);
          }
        }
        break;

      case 'unit':
        if (row.data != null) {
          final result =
              await _openProductUnitsDialog(context, productUnit!.product!.id!);
          if (result.isNotEmpty) {
            query = productUnit.product!.code.toString();
            previewInvoiceItem = await _previewInvoiceItem(context, query,
                productUnitId: result['unit_id'].toString());
          }
        }
        break;
      default:
        if (row.data != null) {
          previewInvoiceItem = await _previewInvoiceItem(
              context, productUnit!.product!.code.toString(),
              productUnitId: productUnit.unit!.id.toString());
        }
        break;
    }

    if (previewInvoiceItem != null) {
      InvoiceItemEntity updatedInvoiceItem =
          _updateInvoiceItemEntity(row, previewInvoiceItem);
      row.data = updatedInvoiceItem;

      final updates = {
        'code': updatedInvoiceItem.productUnit?.product?.code,
        'name': updatedInvoiceItem.productUnit?.product?.arName,
        'quantity': updatedInvoiceItem.quantity,
        'unit': updatedInvoiceItem.productUnit?.unit?.arName,
        'price': updatedInvoiceItem.price,
        'sub_total': updatedInvoiceItem.total,
        'tax_amount': updatedInvoiceItem.taxAmount,
        'total': updatedInvoiceItem.total! + updatedInvoiceItem.taxAmount!,
        'notes': updatedInvoiceItem.description,
      };

      // Apply updates to the grid
      _updateGridCells(onChangeEvent, updates);

      _plutoGridController.stateManager?.notifyListeners();
    }
  }

  Future<PreviewInvoiceItemEntity?> _previewInvoiceItem(
      BuildContext context, String query,
      {String? productUnitId}) async {
    InvoiceAccountEntity? account =
        context.read<InvoiceFormCubit>().accountController;
    final data = await context.read<InvoiceBloc>().previewInvoiceItem(
        query: query, accountId: account.id, productUnitId: productUnitId);
    return data;
  }

  InvoiceItemEntity _updateInvoiceItemEntity(
      PlutoRow<dynamic> row, PreviewInvoiceItemEntity data) {
    InvoiceItemEntity currentInvoiceItem =
        row.data ?? const InvoiceItemEntity();
    InvoiceProductUnitEntity productUnit =
        currentInvoiceItem.productUnit ?? const InvoiceProductUnitEntity();
    InvoiceProductEntity product =
        productUnit.product ?? const InvoiceProductEntity();
    InvoiceUnitEntity unit = productUnit.unit ?? const InvoiceUnitEntity();

    // Update product and unit details
    final updatedProduct = product.copyWith(
      id: data.id,
      arName: data.arName,
      enName: data.enName,
      code: data.code,
    );

    final updatedUnit = unit.copyWith(
      arName: data.productUnit.arName,
      enName: data.productUnit.enName,
    );

    final updatedProductUnit = productUnit.copyWith(
      id: data.productUnit.id,
      product: updatedProduct,
      unit: updatedUnit,
    );

    // Update invoice item
    final updatedInvoiceItem = currentInvoiceItem.copyWith(
      price: data.productUnit.price,
      quantity: 1,
      taxAmount: 2,
      total: 3,
      description: '',
      productUnit: updatedProductUnit,
    );
    return updatedInvoiceItem;
  }

  void _updateGridCells(
      PlutoGridOnChangedEvent onChangeEvent, Map<String, dynamic> updates) {
    for (var entry in updates.entries) {
      updateCurrentCell(onChangeEvent, entry.key, entry.value);
    }
  }

  updateCurrentCell(
      PlutoGridOnChangedEvent onChangeEvent, String cell, dynamic value) {
    onChangeEvent.row.cells[cell]!.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.5,
      child: CustomPlutoTable(
        controller: _plutoGridController,
        mode: readOnly ? PlutoGridMode.readOnly : PlutoGridMode.normal,
        noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
        columns: _buildColumns(),
        rows: invoice!.invoiceItems == null
            ? _buildEmptyRows().toList()
            : _buildFilledRows().toList(),
        showDefaultHeader: true,
        customHeader: _buildCustomHeader(context),
        onChanged: (p0) {
          _plutoGridController.onChanged(p0);
          _onChange(context, p0);
        },
        onLoaded: (event) {
          _plutoGridController =
              PlutoGridController(stateManager: event.stateManager);
          context.read<InvoiceBloc>().setStateManager = event.stateManager;
        },
      ),
    );
  }

  Widget _buildCustomHeader(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
            icon: Icons.copy,
            tooltip: '${'copy'.tr} ${'table'.tr} ',
            onPressed: () {}),
      ],
    );
  }

  List<PlutoColumn> _buildColumns() {
    return [
      _buildCustomColumn('code'),
      _buildCustomColumn('name', readOnly: true),
      _buildCustomColumn('quantity', showSum: true),
      _buildCustomColumn('unit', showSum: true),
      _buildCustomColumn('price'),
      _buildCustomColumn('sub_total', showSum: true, readOnly: true),
      _buildCustomColumn('tax_amount', showSum: true, readOnly: true),
      _buildCustomColumn('total', showSum: true, readOnly: true),
      _buildCustomColumn('notes'),
    ];
  }

  List<PlutoRow> _buildEmptyRows() {
    return [
      PlutoRow(
        type: PlutoRowTypeGroup(children: FilteredList()),
        cells: {
          'code': PlutoCell(value: ''),
          'name': PlutoCell(value: ''),
          'quantity': PlutoCell(value: ''),
          'unit': PlutoCell(value: ''),
          'price': PlutoCell(value: ''),
          'sub_total': PlutoCell(value: ''),
          'tax_amount': PlutoCell(value: ''),
          'total': PlutoCell(value: ''),
          'notes': PlutoCell(value: ''),
        },
      )
    ];
  }

  Iterable<PlutoRow> _buildFilledRows() {
    return invoice!.invoiceItems!.map(
      (invoiceItem) {
        var product = invoiceItem.productUnit!.product;
        var unit = invoiceItem.productUnit!.unit;
        return PlutoRow(
          data: invoiceItem,
          cells: {
            'code': PlutoCell(value: product!.code),
            'name': PlutoCell(value: '${product.arName} - ${product.enName}'),
            'quantity': PlutoCell(value: invoiceItem.quantity),
            'unit': PlutoCell(value: unit!.arName),
            'price': PlutoCell(value: invoiceItem.price),
            'sub_total': PlutoCell(value: invoiceItem.total),
            'tax_amount': PlutoCell(value: invoiceItem.taxAmount),
            'total':
                PlutoCell(value: invoiceItem.total! + invoiceItem.taxAmount!),
            'notes': PlutoCell(value: invoiceItem.description),
          },
        );
      },
    );
  }

  PlutoColumn _buildCustomColumn(String title,
      {bool readOnly = false, bool showSum = false, PlutoColumnType? type}) {
    return PlutoColumn(
      title: title.tr,
      field: title,
      type: type ?? PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.center,
      enableSorting: false,
      enableContextMenu: false,
      enableFilterMenuItem: false,
      readOnly: readOnly,
      footerRenderer: (context) {
        if (showSum) {
          return Center(
            child: Text(
              _plutoGridController
                  .columnSum(
                    context.column.field,
                  )
                  .toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
