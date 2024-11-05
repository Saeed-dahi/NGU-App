import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';

import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';

import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';
import 'package:ngu_app/features/journals/presentation/bloc/journal_bloc.dart';

import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomJournalVouchersPlutoTable extends StatelessWidget {
  final JournalEntity? journalEntity;

  CustomJournalVouchersPlutoTable({super.key, this.journalEntity});

  late PlutoGridController _plutoGridController = PlutoGridController();

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
          tooltip: 'balance'.tr,
          onPressed: () {
            _makeTableBalanced();
          },
        ),
      ],
    );
  }

  void _makeTableBalanced() {
    double debitSum = _plutoGridController.columnSum(
        'debit', _plutoGridController.stateManager!);
    double creditSum = _plutoGridController.columnSum(
        'credit', _plutoGridController.stateManager!);
    String cellToFixed = debitSum > creditSum ? 'credit' : 'debit';
    double balanceValue = (debitSum - creditSum).abs();

    if (balanceValue > 0) {
      final newRow = PlutoRow(
        cells: {
          for (final entry
              in _plutoGridController.stateManager!.rows.first.cells.entries)
            entry.key:
                PlutoCell(value: entry.key == cellToFixed ? balanceValue : '')
        },
      );
      _plutoGridController.stateManager!.appendRows([newRow]);
    }
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
      enableAutoEditing: true,
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
