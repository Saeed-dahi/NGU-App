import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_entity.dart';

import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomAdjustmentNotesPlutoTable extends StatelessWidget {
  final List<AdjustmentNoteEntity> invoices;
  late PlutoGridController _plutoGridController = PlutoGridController();

  CustomAdjustmentNotesPlutoTable({
    super.key,
    required this.invoices,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.85,
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
      _buildCustomColumn('invoice_number'),
      _buildCustomColumn('status'),
      _buildCustomColumn('date'),
      _buildCustomColumn('account_name'),
      _buildCustomColumn('sub_total'),
      _buildCustomColumn('total'),
    ];
  }

  _buildCustomColumn(String field) {
    return PlutoColumn(
        title: field.tr, field: field, type: PlutoColumnType.text());
  }

  Iterable<PlutoRow> _buildRows() {
    return invoices.map(
      (invoice) {
        return PlutoRow(
          type: PlutoRowTypeGroup(children: FilteredList()),
          data: invoice.id,
          cells: {
            'invoice_number': PlutoCell(value: invoice.invoiceNumber),
            'status': PlutoCell(value: invoice.status!.tr),
            'date': PlutoCell(value: invoice.date),
            'account_name': PlutoCell(
                value:
                    '${invoice.account!.arName} - ${invoice.account!.enName}'),
            'sub_total': PlutoCell(value: invoice.subTotal),
            'total': PlutoCell(value: invoice.total),
          },
        );
      },
    );
  }
}
