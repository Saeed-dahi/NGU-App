import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomInvoicePlutoTable extends StatelessWidget {
  final InvoiceEntity? invoice;
  final bool readOnly;

  CustomInvoicePlutoTable({super.key, this.invoice, this.readOnly = false});

  late PlutoGridController _plutoGridController = PlutoGridController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.5,
      child: CustomPlutoTable(
        controller: _plutoGridController,
        mode: readOnly ? PlutoGridMode.readOnly : PlutoGridMode.normal,
        onLoaded: (event) {
          _plutoGridController =
              PlutoGridController(stateManager: event.stateManager);
        },
        noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
        columns: _buildColumns(),
        rows: invoice != null ? _buildFilledRows().toList() : _buildEmptyRows(),
        onChanged: (p0) {
          _plutoGridController.onChanged(p0);
        },
        showDefaultHeader: true,
        customHeader: _buildCustomHeader(context),
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
      _buildCustomColumn('name'),
      _buildCustomColumn('quantity'),
      _buildCustomColumn('unit', readOnly: true),
      _buildCustomColumn('price'),
      _buildCustomColumn('total'),
      _buildCustomColumn('discount'),
      _buildCustomColumn('notes'),
    ];
  }

  Iterable<PlutoRow> _buildFilledRows() {
    return invoice!.invoiceItems.map(
      (invoiceItem) {
        return PlutoRow(
          type: PlutoRowTypeGroup(children: FilteredList()),
          data: invoiceItem.id,
          cells: {
            'code': PlutoCell(value: '1205'),
            'name': PlutoCell(value: 'جبنة'),
            'quantity': PlutoCell(value: invoiceItem.quantity),
            'unit': PlutoCell(value: 'كرتونة'),
            'price': PlutoCell(value: invoiceItem.price),
            'total': PlutoCell(value: invoiceItem.total),
            'discount': PlutoCell(value: invoiceItem.discountAmount),
            'notes': PlutoCell(value: invoiceItem.description),
          },
        );
      },
    );
  }

  List<PlutoRow> _buildEmptyRows() {
    return [
      PlutoRow(
        type: PlutoRowTypeGroup(children: FilteredList()),
        cells: {
          'debit': PlutoCell(value: ''),
          'credit': PlutoCell(value: ''),
          'account_code': PlutoCell(value: ''),
          'account_name': PlutoCell(value: ''),
          'description': PlutoCell(value: ''),
          'document_number': PlutoCell(value: ''),
        },
      )
    ];
  }

  PlutoColumn _buildCustomColumn(String title, {bool readOnly = false}) {
    return PlutoColumn(
      title: title.tr,
      field: title,
      type: PlutoColumnType.text(),
      // enableAutoEditing: true,
      textAlign: PlutoColumnTextAlign.center,
      enableSorting: false,
      enableContextMenu: false,
      enableFilterMenuItem: false,
      readOnly: readOnly,
      footerRenderer: (context) {
        if (title == 'debit' || title == 'credit') {
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
