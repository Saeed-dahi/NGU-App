import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

import 'package:ngu_app/app/app_management/app_strings.dart';

import 'package:ngu_app/core/utils/enums.dart';

import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';
import 'package:ngu_app/features/journals/presentation/bloc/journal_bloc.dart';

import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomJournalVouchersPlutoTable extends StatefulWidget {
  final JournalEntity? journalEntity;

  const CustomJournalVouchersPlutoTable({super.key, this.journalEntity});

  @override
  State<CustomJournalVouchersPlutoTable> createState() =>
      _CustomJournalVouchersPlutoTableState();
}

class _CustomJournalVouchersPlutoTableState
    extends State<CustomJournalVouchersPlutoTable> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.65,
      child: CustomPlutoTable(
          controller: PlutoGridController(),
          mode: PlutoGridMode.normal,
          onLoaded: (event) {
            BlocProvider.of<JournalBloc>(context).setStateManager =
                event.stateManager;
          },
          noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
          columns: _buildColumns(),
          rows: widget.journalEntity != null
              ? _buildFilledRows().toList()
              : _buildEmptyRows(),
          onChanged: _onChanged),
    );
  }

  _onChanged(PlutoGridOnChangedEvent event) {
    if (event.column.field == 'debit' && event.value != null) {
      event.row.cells['credit']!.value = '';
    }
    if (event.column.field == 'credit' && event.value != null) {
      event.row.cells['debit']!.value = '';
    }
    setState(() {});
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
    return widget.journalEntity!.transactions.map(
      (transaction) {
        return PlutoRow(
          type: PlutoRowTypeGroup(children: FilteredList()),
          data: transaction.id,
          cells: {
            'debit': PlutoCell(
                value: transaction.type == AccountNature.debit.name
                    ? transaction.amount
                    : ''),
            'credit': PlutoCell(
                value: transaction.type == AccountNature.credit.name
                    ? transaction.amount
                    : ''),
            'account_code': PlutoCell(value: transaction.accountName),
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
              columnSum(
                context.column.field,
                context.stateManager,
              ).toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  double columnSum(String columnName, PlutoGridStateManager stateManager) {
    var rows = stateManager.rows;
    double debitSum = 0;

    for (var transaction in rows) {
      debitSum +=
          double.tryParse(transaction.cells[columnName]!.value.toString()) ?? 0;
    }
    return debitSum;
  }
}
