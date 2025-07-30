import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/accounts/presentation/pages/accounts_table.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomVisaTransactionPlutoTable extends StatelessWidget {
  late PlutoGridController _plutoGridController = PlutoGridController();
  final Map<String, dynamic> accountsName = {};

  CustomVisaTransactionPlutoTable({super.key});

  Future<void> _getAccountName(BuildContext context) async {
    if (_plutoGridController.stateManager!.currentColumn!.field ==
        'account_code') {
      final currentRow = _plutoGridController.stateManager!.currentRow!;

      for (final entry in currentRow.cells.entries) {
        final currentCellValue = currentRow.cells[entry.key]?.value;

        // Check if we're setting the account name
        if (entry.key == 'account_name') {
          final accountCode =
              currentRow.cells['account_code']!.value.toString();
          final accountName = accountsName[accountCode];
          final accountId = accountsName['id_$accountCode'];

          // Check if the account name exists in the map
          if (accountName != null) {
            currentRow.cells[entry.key]?.value = accountName;
            currentRow.data = int.parse(accountId);
          } else {
            // If not found, open dialog and await result
            final result = await _openAccountDialog(context, accountCode);
            if (result.isNotEmpty) {
              // Set account name and code based on dialog result
              currentRow.cells['account_code']?.value = result['account_code'];
              currentRow.cells['account_name']?.value = result['account_name'];
              currentRow.data = result['account_id'];
            }
          }
        } else {
          // For other fields, keep their current value
          currentRow.cells[entry.key]?.value = currentCellValue;
        }
      }
    }
    _plutoGridController.stateManager!.notifyListeners();
  }

  Future<Map<String, dynamic>> _openAccountDialog(
      BuildContext context, String acc) async {
    final result = await ShowDialog.showCustomDialog(
      context: context,
      content: const AccountsTable(),
    );
    return result ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.55,
      margin: const EdgeInsets.all(Dimensions.primaryPadding),
      child: CustomPlutoTable(
        controller: _plutoGridController,
        mode: PlutoGridMode.normal,
        showDefaultHeader: true,
        noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
        columns: _buildColumns(context),
        rows: _buildRows().toList(),
        onLoaded: (PlutoGridOnLoadedEvent event) {
          _plutoGridController =
              PlutoGridController(stateManager: event.stateManager);
        },
        onChanged: (p0) {
          _plutoGridController.onChanged(p0);
          _getAccountName(context);
        },
      ),
    );
  }

  List<PlutoColumn> _buildColumns(BuildContext context) {
    return [
      _buildCustomColumn('account_code'),
      _buildCustomColumn('account_name', readOnly: true),
      _buildCustomColumn('amount', showSum: true),
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
      (item) {
        return PlutoRow(
          type: PlutoRowTypeGroup(children: FilteredList()),
          cells: {
            'account_code': PlutoCell(value: item.accountCode),
            'account_name': PlutoCell(value: item.accountName),
            'amount': PlutoCell(value: item.unitName),
            'notes': PlutoCell(value: item.price),
          },
        );
      },
    );
  }
}
