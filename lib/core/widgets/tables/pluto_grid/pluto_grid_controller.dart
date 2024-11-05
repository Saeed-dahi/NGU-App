import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngu_app/app/lang/localization_service.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class PlutoGridController {
  PlutoGridStateManager? stateManager;

  PlutoGridController({this.stateManager});

  set setStateManager(PlutoGridStateManager sts) => stateManager = sts;

  PlutoGridLocaleText getLocaleText() {
    return LocalizationService.isArabic
        ? const PlutoGridLocaleText.arabic()
        : const PlutoGridLocaleText();
  }

  PlutoGridShortcut customArabicGridShortcut() {
    return LocalizationService.isArabic
        ? PlutoGridShortcut(
            actions: {
              ...PlutoGridShortcut.defaultActions,
              LogicalKeySet(LogicalKeyboardKey.arrowRight):
                  const PlutoGridActionMoveCellFocus(PlutoMoveDirection.left),
              LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                  const PlutoGridActionMoveCellFocus(PlutoMoveDirection.right),
              LogicalKeySet(LogicalKeyboardKey.enter): CustomEnterKeyAction(),
            },
          )
        : const PlutoGridShortcut();
  }

  // add new row
  void appendNewRow(PlutoGridStateManager stateManager) {
    stateManager.appendNewRows(count: 1);
  }

  // remove current row
  void removeCurrentRow(PlutoGridStateManager stateManager) {
    stateManager.removeCurrentRow();
    _moveFocusToLastRow(stateManager);
  }

  // repeat previous row but do not change current values if it is not empty
  void repeatPreviousRow(PlutoGridStateManager stateManager) {
    final currentRow = stateManager.currentRow;

    if (currentRow != null) {
      final currentIndex = stateManager.rows.indexOf(currentRow);

      if (currentIndex > 0) {
        final previousRow = stateManager.rows[currentIndex - 1];

        for (final entry in previousRow.cells.entries) {
          currentRow.cells[entry.key]?.value = entry.value.value;
        }
        stateManager.moveCurrentCell(PlutoMoveDirection.right, force: true);
      }
    }
    moveToNextRowFirstColumn(stateManager);
  }

  // repeat previous column but do not change current values if it is not empty
  void repeatPreviousColumn(PlutoGridStateManager stateManager) {
    final currentRow = stateManager.currentRow;
    final currentCell = stateManager.currentCell;

    if (currentRow != null && currentCell != null) {
      final currentIndex = stateManager.rows.indexOf(currentRow);

      if (currentIndex > 0) {
        final previousRow = stateManager.rows[currentIndex - 1];
        final targetColumn = currentCell.column.field;

        for (final entry in previousRow.cells.entries) {
          final currentCellValue = currentRow.cells[entry.key]?.value;
          currentRow.cells[entry.key]?.value =
              entry.key == targetColumn ? entry.value.value : currentCellValue;
        }
      }
    }
    bestMove(stateManager);
  }

  // move the focus to the last row of the table
  void _moveFocusToLastRow(PlutoGridStateManager stateManager) {
    stateManager.setCurrentCell(stateManager.rows.last.cells.values.first,
        stateManager.rows.length - 1);
  }

  // Move to the best place (horizontal or vertical)
  void bestMove(PlutoGridStateManager stateManager) {
    if (isAtLastColumn(stateManager)) {
      moveToNextRowFirstColumn(stateManager);
    } else {
      moveRight(stateManager);
    }
  }

  // Checks if the current cell is in the last column
  bool isAtLastColumn(PlutoGridStateManager stateManager) {
    return stateManager.currentColumn?.field == stateManager.columns.last.field;
  }

  // Moves to the first column in the next row
  void moveToNextRowFirstColumn(PlutoGridStateManager stateManager) async {
    // Add new Row if we at the end of table
    addNewRow(stateManager);

    stateManager.moveCurrentCell(PlutoMoveDirection.down);
    if (stateManager.currentRowIdx != null &&
        stateManager.currentRowIdx! < stateManager.rows.length) {
      stateManager.setCurrentCell(
        stateManager.rows[stateManager.currentRowIdx!]
            .cells[stateManager.columns.first.field],
        stateManager.currentRowIdx!,
      );
    }
  }

  // add new Row if we are in the last row
  void addNewRow(PlutoGridStateManager stateManager) {
    if (stateManager.currentRow == stateManager.rows.last) {
      stateManager.appendNewRows(count: 1);
    }
  }

  // Moves horizontally to the right within the same row
  void moveRight(PlutoGridStateManager stateManager) {
    stateManager.moveCurrentCell(PlutoMoveDirection.right, force: true);
    if (stateManager.currentCell!.column.readOnly == true) {
      stateManager.moveCurrentCell(PlutoMoveDirection.right, force: true);
    }
  }

  double columnSum(String columnName, PlutoGridStateManager stateManager) {
    var rows = stateManager.rows;
    double sum = 0;

    for (var transaction in rows) {
      sum += FormatterClass.doubleFormatter(
              transaction.cells[columnName]!.value.toString()) ??
          0;
    }
    return sum;
  }

  onChanged(PlutoGridOnChangedEvent event) {
    if (event.column.field == 'debit' && event.value != null) {
      event.row.cells['credit']!.value = '';
      event.row.cells['debit']!.value =
          FormatterClass.numberFormatter(event.value);
    }
    if (event.column.field == 'credit' && event.value != null) {
      event.row.cells['debit']!.value = '';
      event.row.cells['credit']!.value =
          FormatterClass.numberFormatter(event.value);
    }
  }
}

class CustomEnterKeyAction extends PlutoGridShortcutAction {
  late PlutoGridController _plutoGridController;
  @override
  void execute({
    required PlutoKeyManagerEvent keyEvent,
    required PlutoGridStateManager stateManager,
  }) {
    _plutoGridController = PlutoGridController(stateManager: stateManager);

    // If at the last column, move to the next row's first column
    _plutoGridController.bestMove(stateManager);
  }
}
