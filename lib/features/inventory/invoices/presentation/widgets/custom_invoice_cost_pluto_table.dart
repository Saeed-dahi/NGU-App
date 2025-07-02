import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_cost_entity.dart';

import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomInvoiceCostPlutoTable extends StatelessWidget {
  final InvoiceCostEntity invoiceCost;
  late PlutoGridController _plutoGridController = PlutoGridController();

  CustomInvoiceCostPlutoTable({
    super.key,
    required this.invoiceCost,
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
        customFooter: _customFooter(),
        columns: _buildColumns(context),
        rows: _buildRows().toList(),
        onLoaded: (PlutoGridOnLoadedEvent event) {
          _plutoGridController =
              PlutoGridController(stateManager: event.stateManager);
        },
      ),
    );
  }

  Widget _customFooter() {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _footerItem('${'total'.tr}: ', invoiceCost.totalAmount!),
          _footerItem('${'cost'.tr}: ', invoiceCost.costTotal!),
          _footerItem('${'profit'.tr}: ', invoiceCost.profitTotal!),
        ],
      ),
    );
  }

  Row _footerItem(String label, double value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: Dimensions.secondaryTextSize,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor),
        ),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: Dimensions.secondaryTextSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  List<PlutoColumn> _buildColumns(BuildContext context) {
    return [
      _buildCustomColumn('product'),
      _buildCustomColumn('unit'),
      _buildCustomColumn('price'),
      _buildCustomColumn('last_purchase_price'),
      _buildCustomColumn('last_purchase_date'),
      _buildCustomColumn('difference'),
    ];
  }

  PlutoColumn _buildCustomColumn(String title,
      {bool readOnly = false,
      bool enableEditingMode = true,
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
    );
  }

  Iterable<PlutoRow> _buildRows() {
    return invoiceCost.items!.map(
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
