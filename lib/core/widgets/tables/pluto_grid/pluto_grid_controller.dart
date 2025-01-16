import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngu_app/app/lang/localization_service.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class PlutoGridController {
  PlutoGridStateManager? stateManager;
  set setStateManager(PlutoGridStateManager sts) => stateManager = sts;

  VoidCallback? enterKeyAction;
  set setEnterKeyAction(VoidCallback? action) => enterKeyAction = action;

  final Map<ShortcutActivator, PlutoGridShortcutAction> _customKeysMap = {};
  final List<LogicalKeyboardKey> numpadKeys = [];

  PlutoGridController({this.stateManager}) {
    _initializeShortcuts();
  }

  // Initialize shortcuts
  void _initializeShortcuts() {
    final customAction = CustomPlutoKeyAction(plutoGridController: this);

    _customKeysMap.addAll({
      LogicalKeySet(LogicalKeyboardKey.enter): customAction,
      LogicalKeySet(LogicalKeyboardKey.f10): customAction,
      LogicalKeySet(LogicalKeyboardKey.f9): customAction,
      LogicalKeySet(LogicalKeyboardKey.f3): customAction,
      LogicalKeySet(LogicalKeyboardKey.f4): customAction,
      LogicalKeySet(LogicalKeyboardKey.f5): customAction,
    });

    numpadKeys.addAll([
      LogicalKeyboardKey.numpad0,
      LogicalKeyboardKey.numpad1,
      LogicalKeyboardKey.numpad2,
      LogicalKeyboardKey.numpad3,
      LogicalKeyboardKey.numpad4,
      LogicalKeyboardKey.numpad5,
      LogicalKeyboardKey.numpad6,
      LogicalKeyboardKey.numpad7,
      LogicalKeyboardKey.numpad8,
      LogicalKeyboardKey.numpad9,
    ]);
  }

  PlutoGridLocaleText getLocaleText() {
    return LocalizationService.isArabic
        ? const PlutoGridLocaleText.arabic()
        : const PlutoGridLocaleText();
  }

  PlutoGridShortcut customArabicGridShortcut() {
    for (final key in numpadKeys) {
      _customKeysMap[LogicalKeySet(key)] =
          CustomPlutoKeyAction(plutoGridController: this);
    }

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
            LogicalKeySet(LogicalKeyboardKey.enter):
                CustomPlutoKeyAction(plutoGridController: this),
          });
  }

  // add new row
  void appendNewRow() {
    stateManager!.appendNewRows(count: 1);
  }

  // remove current row
  void removeCurrentRow() {
    stateManager!.removeCurrentRow();
    _moveFocusToLastRow();
  }

  // repeat previous row but do not change current values if it is not empty
  void repeatPreviousRow() {
    final currentRow = stateManager!.currentRow;

    if (currentRow != null) {
      final currentIndex = stateManager!.rows.indexOf(currentRow);

      if (currentIndex > 0) {
        final previousRow = stateManager!.rows[currentIndex - 1];

        for (final entry in previousRow.cells.entries) {
          currentRow.cells[entry.key]?.value = entry.value.value;
        }
        stateManager!.moveCurrentCell(PlutoMoveDirection.right, force: true);
      }
    }

    moveToNextRowFirstColumn();
  }

  // repeat previous column but do not change current values if it is not empty
  void repeatPreviousColumn() {
    final currentRow = stateManager!.currentRow;
    final currentCell = stateManager!.currentCell;

    if (currentRow != null && currentCell != null) {
      final currentIndex = stateManager!.rows.indexOf(currentRow);

      if (currentIndex > 0) {
        final previousRow = stateManager!.rows[currentIndex - 1];
        final targetColumn = currentCell.column.field;

        for (final entry in previousRow.cells.entries) {
          final currentCellValue = currentRow.cells[entry.key]?.value;
          currentRow.cells[entry.key]?.value =
              entry.key == targetColumn ? entry.value.value : currentCellValue;
        }
      }
    }

    bestMove();
  }

  // move the focus to the last row of the table
  void _moveFocusToLastRow() {
    stateManager!.setCurrentCell(stateManager!.rows.last.cells.values.first,
        stateManager!.rows.length - 1);
  }

  // Move to the best place (horizontal or vertical)
  void bestMove() {
    if (enterKeyAction != null) {
      enterKeyAction!();
    } else if (isAtLastColumn(stateManager!)) {
      moveToNextRowFirstColumn();
    } else {
      moveRight();
    }
  }

  // Checks if the current cell is in the last column
  bool isAtLastColumn(PlutoGridStateManager stateManager) {
    return stateManager.currentColumn?.field == stateManager.columns.last.field;
  }

  // Moves to the first column in the next row
  void moveToNextRowFirstColumn() async {
    // Add new Row if we at the end of table
    addNewRow();

    stateManager!.moveCurrentCell(PlutoMoveDirection.down);
    if (stateManager!.currentRowIdx != null &&
        stateManager!.currentRowIdx! < stateManager!.rows.length) {
      stateManager!.setCurrentCell(
        stateManager!.rows[stateManager!.currentRowIdx!]
            .cells[stateManager!.columns.first.field],
        stateManager!.currentRowIdx!,
      );
    }
  }

  // add new Row if we are in the last row
  void addNewRow() {
    if (stateManager!.currentRow == stateManager!.rows.last &&
        stateManager!.mode != PlutoGridMode.readOnly) {
      stateManager!.appendNewRows(count: 1);
    }
  }

  // Moves horizontally to the right within the same row
  void moveRight() {
    stateManager!.moveCurrentCell(PlutoMoveDirection.right, force: true);
    final currentCell = stateManager!.currentCell;
    if (currentCell != null) {
      if (currentCell.column.readOnly == true) {
        stateManager!.moveCurrentCell(PlutoMoveDirection.right, force: true);
      }
    }
  }

  double columnSum(String columnName) {
    var rows = stateManager!.rows;
    double sum = 0;

    for (var transaction in rows) {
      var doubleFormatter = FormatterClass.doubleFormatter(
              transaction.cells[columnName]!.value.toString()) ??
          0;

      sum += doubleFormatter;
    }

    return sum;
  }

  onChanged(event) {
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
    double debitSum = columnSum('debit');
    double creditSum = columnSum('credit');
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

  void searchFunction(String query) {
    stateManager!.setFilter(
      (row) {
        Map<String, dynamic> fields = {};
        for (var column in stateManager!.columns) {
          fields[column.field] = FormatterClass.normalizeArabic(
            row.cells[column.field]!.value.toString().toLowerCase(),
          );
        }
        var result = false;
        for (var field in fields.values) {
          if (field
              .contains(FormatterClass.normalizeArabic(query.toLowerCase()))) {
            result = true;
            break;
          }
        }
        return result;
      },
    );
  }

  List<PlutoColumn> initNumbersForColumns(List<PlutoColumn> columns) {
    columns.insert(
        0,
        PlutoColumn(
          title: 'No',
          field: 'number',
          type: PlutoColumnType.number(),
          readOnly: true,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          width: 60,
        ));
    return columns;
  }

  List<PlutoRow> initNumbersForRows(List<PlutoRow> rows) {
    return rows.asMap().entries.map((entry) {
      final index = entry.key;
      final row = entry.value;

      // Add the row number to the first column
      final updatedCells = Map<String, PlutoCell>.from(row.cells);
      updatedCells['number'] = PlutoCell(value: index + 1);

      return PlutoRow(cells: updatedCells);
    }).toList();
  }

  handleNumberPadKeyEvent(PlutoKeyManagerEvent keyEvent) {
    if (numpadKeys.contains(keyEvent.event.logicalKey)) {
      final newValue = keyEvent.event.logicalKey.keyLabel.characters.last;
      stateManager!.currentCell!.value = newValue;
      stateManager!.setEditing(true);
      stateManager!.notifyListeners();
    }
  }
}

class CustomPlutoKeyAction extends PlutoGridShortcutAction {
  PlutoGridController plutoGridController;

  CustomPlutoKeyAction({required this.plutoGridController});
  @override
  void execute({
    required PlutoKeyManagerEvent keyEvent,
    required PlutoGridStateManager stateManager,
  }) {
    plutoGridController.handleNumberPadKeyEvent(keyEvent);

    // If at the last column, move to the next row's first column
    switch (keyEvent.event.logicalKey) {
      case LogicalKeyboardKey.enter:
        plutoGridController.bestMove();
        break;
      case LogicalKeyboardKey.f10:
        plutoGridController.appendNewRow();
        break;
      case LogicalKeyboardKey.f9:
        plutoGridController.removeCurrentRow();
        break;
      case LogicalKeyboardKey.f3:
        plutoGridController.makeTableBalanced();
        break;
      case LogicalKeyboardKey.f4:
        plutoGridController.repeatPreviousColumn();
        break;
      case LogicalKeyboardKey.f5:
        plutoGridController.repeatPreviousRow();
        break;
    }
  }
}
