import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomChequesPlutoTable extends StatelessWidget {
  late PlutoGridController _plutoGridController = PlutoGridController();
  final List<ChequeEntity> cheques;

  CustomChequesPlutoTable({super.key, required this.cheques});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.8,
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
      _buildCustomColumn('debit', showSum: true),
      _buildCustomColumn('credit', showSum: true),
      _buildCustomColumn('issued_from_account'),
      _buildCustomColumn('target_bank_account'),
      _buildCustomColumn('issued_to_account'),
      _buildCustomColumn('description'),
      _buildCustomColumn('due_date'),
      _buildCustomColumn('date'),
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
    return cheques.map(
      (cheque) {
        return PlutoRow(
          type: PlutoRowTypeGroup(children: FilteredList()),
          data: cheque.id,
          cells: {
            'debit': PlutoCell(
                value: cheque.nature == ChequeNature.incoming.name
                    ? cheque.amount
                    : ''),
            'credit': PlutoCell(
                value: cheque.nature == ChequeNature.outgoing.name
                    ? cheque.amount
                    : ''),
            'issued_from_account':
                PlutoCell(value: cheque.issuedFromAccount!.arName),
            'target_bank_account':
                PlutoCell(value: cheque.targetBankAccount!.arName),
            'issued_to_account':
                PlutoCell(value: cheque.issuedToAccount!.arName),
            'description': PlutoCell(value: cheque.notes),
            'due_date': PlutoCell(value: cheque.dueDate),
            'date': PlutoCell(value: cheque.date),
          },
        );
      },
    );
  }
}
