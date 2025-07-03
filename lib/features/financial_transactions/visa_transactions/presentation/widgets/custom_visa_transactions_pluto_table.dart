import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/cheques/presentation/pages/cheque_record.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomVisaTransactionsPlutoTable extends StatelessWidget {
  late PlutoGridController _plutoGridController = PlutoGridController();

  CustomVisaTransactionsPlutoTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.8,
      margin: const EdgeInsets.all(Dimensions.primaryPadding),
      child: CustomPlutoTable(
        controller: _plutoGridController,
        mode: PlutoGridMode.readOnly,
        noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
        onRowDoubleTap: (p0) {
          ShowDialog.showCustomDialog(
            context: context,
            content: ChequeRecord(accountId: p0.row.data),
            height: 0.5,
            width: 0.7,
          );
        },
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
      _buildCustomColumn('gross_amount', showSum: true),
      _buildCustomColumn('commission_rate', showSum: true),
      _buildCustomColumn('commission_amount', showSum: true),
      _buildCustomColumn('net_amount', showSum: true),
      _buildCustomColumn('bank_account'),
      _buildCustomColumn('visa_account'),
      _buildCustomColumn('commission_account'),
      _buildCustomColumn('notes'),
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
    return [].map(
      (cheque) {
        return PlutoRow(
          type: PlutoRowTypeGroup(children: FilteredList()),
          data: cheque.id,
          cells: {
            'gross_amount': PlutoCell(
                value: cheque.nature == ChequeNature.incoming.name
                    ? cheque.amount
                    : ''),
            'commission_rate': PlutoCell(
                value: cheque.nature == ChequeNature.outgoing.name
                    ? cheque.amount
                    : ''),
            'commission_amount':
                PlutoCell(value: cheque.issuedFromAccount!.arName),
            'net_amount': PlutoCell(value: cheque.targetBankAccount!.arName),
            'bank_account': PlutoCell(value: cheque.issuedToAccount!.arName),
            'visa_account': PlutoCell(value: cheque.visaAccount!.arName),
            'commission_account':
                PlutoCell(value: cheque.commissionAccount!.arName),
            'notes': PlutoCell(value: cheque.notes),
          },
        );
      },
    );
  }
}
