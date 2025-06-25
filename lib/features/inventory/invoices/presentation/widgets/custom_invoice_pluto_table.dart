import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_bloc/invoice_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_form_cubit/invoice_form_cubit.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/preview_invoice_item_cubit/preview_invoice_item_cubit.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomInvoicePlutoTable extends StatelessWidget {
  final InvoiceEntity? invoice;
  final bool readOnly;

  CustomInvoicePlutoTable({super.key, this.invoice, this.readOnly = false});

  late PlutoGridController _plutoGridController = PlutoGridController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.45,
      child: CustomPlutoTable(
        controller: _plutoGridController,
        mode: readOnly ? PlutoGridMode.readOnly : PlutoGridMode.normal,
        noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
        columns: _buildColumns(),
        rows: invoice!.invoiceItems == null
            ? _buildEmptyRows().toList()
            : _buildFilledRows(context).toList(),
        showDefaultHeader: true,
        customHeader: _buildCustomHeader(context),
        onChanged: (p0) {
          context.read<PreviewInvoiceItemCubit>().setOnChangeEvent = p0;
          context
              .read<PreviewInvoiceItemCubit>()
              .onColumnChange(context, _plutoGridController.stateManager);

          context
              .read<InvoiceFormCubit>()
              .updateTotalController(_plutoGridController);
        },
        customSpaceKeyAction: () {
          context.read<PreviewInvoiceItemCubit>().handleUnitColumnChange(
              context, _plutoGridController.stateManager);
        },
        onLoaded: (event) {
          _plutoGridController =
              PlutoGridController(stateManager: event.stateManager);
          context.read<InvoiceBloc>().setPlutoGridController =
              _plutoGridController;
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
      _buildCustomColumn('unit', enableEditingMode: false),
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

  Iterable<PlutoRow> _buildFilledRows(BuildContext context) {
    return invoice!.invoiceItems!.map(
      (invoiceItem) {
        var product = invoiceItem.productUnit!.product;
        var unit = invoiceItem.productUnit!.unit;

        var data = context
            .read<PreviewInvoiceItemCubit>()
            .invoiceItemToPreviewInvoiceItem(product, invoiceItem, unit);

        return PlutoRow(
          data: data,
          cells: {
            'code': PlutoCell(value: product!.code),
            'name': PlutoCell(value: '${product.arName} - ${product.enName}'),
            'quantity': PlutoCell(value: invoiceItem.quantity),
            'unit': PlutoCell(value: unit!.arName),
            'price': PlutoCell(value: invoiceItem.price),
            'sub_total':
                PlutoCell(value: invoiceItem.price! * invoiceItem.quantity!),
            'tax_amount': PlutoCell(value: invoiceItem.taxAmount),
            'total': PlutoCell(value: invoiceItem.total!),
            'notes': PlutoCell(value: invoiceItem.description),
          },
        );
      },
    );
  }

  PlutoColumn _buildCustomColumn(String title,
      {bool readOnly = false,
      bool enableEditingMode = true,
      bool showSum = false,
      PlutoColumnType? type}) {
    return PlutoColumn(
      title: title.tr,
      field: title,
      type: type ?? PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.center,
      enableSorting: false,
      enableContextMenu: false,
      enableFilterMenuItem: false,
      enableEditingMode: enableEditingMode,
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
