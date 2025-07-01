import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_cost_entity.dart';

import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomInvoiceCostPlutoTable extends StatelessWidget {
  final List<InvoiceCostEntityItems> invoiceCostItems;
  late PlutoGridController _plutoGridController = PlutoGridController();

  CustomInvoiceCostPlutoTable({
    super.key,
    required this.invoiceCostItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.6,
      margin: const EdgeInsets.all(Dimensions.primaryPadding),
      child: CustomPlutoTable(
        controller: _plutoGridController,
        mode: PlutoGridMode.readOnly,
        noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
        columns: _buildColumns(context),
        rows: _buildRows().toList(),
        onLoaded: (PlutoGridOnLoadedEvent event) {
          _plutoGridController =
              PlutoGridController(stateManager: event.stateManager);
        },
      ),
    );
  }

  List<PlutoColumn> _buildColumns(BuildContext context) {
    return [
      _buildCustomColumn('product'),
      _buildCustomColumn('unit'),
      _buildCustomColumn('price', showSum: true),
      _buildCustomColumn('last_purchase_price', showSum: true),
      _buildCustomColumn('last_purchase_date', showSum: true),
      _buildCustomColumn('difference', showSum: true),
    ];
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

  Iterable<PlutoRow> _buildRows() {
    return invoiceCostItems.map(
      (item) {
        return PlutoRow(
          type: PlutoRowTypeGroup(children: FilteredList()),
          cells: {
            'product': PlutoCell(value: item.productName),
            'unit': PlutoCell(value: item.unitName),
            'price': PlutoCell(value: item.price),
            'last_purchase_price': PlutoCell(value: item.lastPurchasePrice),
            'last_purchase_date': PlutoCell(value: item.lastPurchaseDate),
            'difference': PlutoCell(value: item.difference),
          },
        );
      },
    );
  }
}
