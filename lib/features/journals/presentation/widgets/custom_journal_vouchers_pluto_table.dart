import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';

import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';

import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/accounts/presentation/pages/accounts_table.dart';
import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';
import 'package:ngu_app/features/journals/presentation/bloc/journal_bloc.dart';

import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomJournalVouchersPlutoTable extends StatelessWidget {
  final JournalEntity? journalEntity;
  final Map<String, dynamic> accountsName;

  CustomJournalVouchersPlutoTable(
      {super.key, this.journalEntity, required this.accountsName});

  late PlutoGridController _plutoGridController = PlutoGridController();

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

          // Check if the account name exists in the map
          if (accountName != null) {
            currentRow.cells[entry.key]?.value = accountName;
          } else {
            // If not found, open dialog and await result
            final result = await _openAccountDialog(context, accountCode);
            if (result.isNotEmpty) {
              // Set account name and code based on dialog result
              currentRow.cells['account_code']?.value = result['account_code'];
              currentRow.cells['account_name']?.value = result['account_name'];
            }
          }
        } else {
          // For other fields, keep their current value
          currentRow.cells[entry.key]?.value = currentCellValue;
        }
      }
    }
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
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.6,
      child: CustomPlutoTable(
        controller: _plutoGridController,
        mode: PlutoGridMode.normal,
        onLoaded: (event) {
          BlocProvider.of<JournalBloc>(context).setStateManager =
              event.stateManager;
          _plutoGridController =
              PlutoGridController(stateManager: event.stateManager);
        },
        noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
        columns: _buildColumns(),
        rows: journalEntity != null
            ? _buildFilledRows().toList()
            : _buildEmptyRows(),
        onChanged: (p0) {
          _plutoGridController.onChanged(p0);

          _getAccountName(context);
        },
        showDefaultHeader: true,
        customHeader: _buildCustomHeader(),
      ),
    );
  }

  Widget _buildCustomHeader() {
    return Row(
      children: [
        CustomIconButton(
          icon: Icons.balance,
          tooltip: '${'balance'.tr} (F3)',
          onPressed: () {
            _plutoGridController.makeTableBalanced();
          },
        ),
      ],
    );
  }

  List<PlutoColumn> _buildColumns() {
    return [
      _buildCustomColumn('debit'),
      _buildCustomColumn('credit'),
      _buildCustomColumn('account_code'),
      _buildCustomColumn('account_name', readOnly: true),
      _buildCustomColumn('description'),
      _buildCustomColumn('document_number'),
    ];
  }

  Iterable<PlutoRow> _buildFilledRows() {
    return journalEntity!.transactions.map(
      (transaction) {
        return PlutoRow(
          type: PlutoRowTypeGroup(children: FilteredList()),
          data: transaction.id,
          cells: {
            'debit': PlutoCell(
                value: transaction.type == AccountNature.debit.name
                    ? FormatterClass.numberFormatter(
                        transaction.amount.toString())
                    : ''),
            'credit': PlutoCell(
                value: transaction.type == AccountNature.credit.name
                    ? FormatterClass.numberFormatter(
                        transaction.amount.toString())
                    : ''),
            'account_code': PlutoCell(value: transaction.accountCode),
            'account_name': PlutoCell(value: transaction.accountName),
            'description': PlutoCell(value: transaction.description),
            'document_number': PlutoCell(value: transaction.documentNumber),
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
                    context.stateManager,
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
