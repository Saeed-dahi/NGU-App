import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngu_app/app/lang/localization_service.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class PlutoGridController {
  PlutoGridStateManager? stateManager;

  final Map<ShortcutActivator, PlutoGridShortcutAction> _customKeysMap = {
    LogicalKeySet(LogicalKeyboardKey.enter): CustomPlutoKeyAction(),
    LogicalKeySet(LogicalKeyboardKey.f10): CustomPlutoKeyAction(),
    LogicalKeySet(LogicalKeyboardKey.f9): CustomPlutoKeyAction(),
    LogicalKeySet(LogicalKeyboardKey.f3): CustomPlutoKeyAction(),
    LogicalKeySet(LogicalKeyboardKey.f4): CustomPlutoKeyAction(),
    LogicalKeySet(LogicalKeyboardKey.f5): CustomPlutoKeyAction(),
  };

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
              ..._customKeysMap,
              LogicalKeySet(LogicalKeyboardKey.arrowRight):
                  const PlutoGridActionMoveCellFocus(PlutoMoveDirection.left),
              LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                  const PlutoGridActionMoveCellFocus(PlutoMoveDirection.right),
            },
          )
        : PlutoGridShortcut(actions: {
            ...PlutoGridShortcut.defaultActions,
            ..._customKeysMap,
            LogicalKeySet(LogicalKeyboardKey.enter): CustomPlutoKeyAction(),
          });
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
    final currentCell = stateManager.currentCell;
    if (currentCell != null) {
      if (currentCell.column.readOnly == true) {
        stateManager.moveCurrentCell(PlutoMoveDirection.right, force: true);
      }
    }
  }

  double columnSum(String columnName, PlutoGridStateManager stateManager) {
    var rows = stateManager.rows;
    double sum = 0;

    for (var transaction in rows) {
      var doubleFormatter = FormatterClass.doubleFormatter(
              transaction.cells[columnName]!.value.toString()) ??
          0;

      sum += doubleFormatter;
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

  void makeTableBalanced() {
    double debitSum = columnSum('debit', stateManager!);
    double creditSum = columnSum('credit', stateManager!);
    String cellToFixed = debitSum > creditSum ? 'credit' : 'debit';
    String cellToRemove = debitSum < creditSum ? 'credit' : 'debit';
    double balanceValue = (debitSum - creditSum).abs();
    final currentRow = stateManager!.currentRow;

    if (balanceValue > 0) {
      if (currentRow != null) {
        for (final entry in currentRow.cells.entries) {
          final currentCellValue = currentRow.cells[entry.key]?.value;
          currentRow.cells[cellToRemove]?.value = '';
          currentRow.cells[entry.key]?.value =
              entry.key == cellToFixed ? balanceValue : currentCellValue;
          stateManager!.notifyListeners();
        }
      } else {
        final newRow = PlutoRow(
          cells: {
            for (final entry in stateManager!.rows.first.cells.entries)
              entry.key:
                  PlutoCell(value: entry.key == cellToFixed ? balanceValue : '')
          },
        );
        stateManager!.appendRows([newRow]);
      }
    }
  }
}

class CustomPlutoKeyAction extends PlutoGridShortcutAction {
  late PlutoGridController _plutoGridController;
  @override
  void execute({
    required PlutoKeyManagerEvent keyEvent,
    required PlutoGridStateManager stateManager,
  }) {
    _plutoGridController = PlutoGridController(stateManager: stateManager);

    // If at the last column, move to the next row's first column
    switch (keyEvent.event.logicalKey) {
      case LogicalKeyboardKey.enter:
        _plutoGridController.bestMove(stateManager);
        break;
      case LogicalKeyboardKey.f10:
        _plutoGridController.appendNewRow(stateManager);
        break;
      case LogicalKeyboardKey.f9:
        _plutoGridController.removeCurrentRow(stateManager);
        break;
      case LogicalKeyboardKey.f3:
        _plutoGridController.makeTableBalanced();
        break;
      case LogicalKeyboardKey.f4:
        _plutoGridController.repeatPreviousColumn(stateManager);
        break;
      case LogicalKeyboardKey.f5:
        _plutoGridController.repeatPreviousRow(stateManager);
        break;
    }
  }
}
