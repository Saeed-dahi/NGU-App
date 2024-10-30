import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngu_app/app/lang/localization_service.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class PlutoGridController {
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
}

class CustomEnterKeyAction extends PlutoGridShortcutAction {
  @override
  void execute({
    required PlutoKeyManagerEvent keyEvent,
    required PlutoGridStateManager stateManager,
  }) {
    // If at the last column, move to the next row's first column
    if (_isAtLastColumn(stateManager)) {
      _moveToNextRowFirstColumn(stateManager);
    } else {
      _moveRight(stateManager);
    }
  }

  // Checks if the current cell is in the last column
  bool _isAtLastColumn(PlutoGridStateManager stateManager) {
    return stateManager.currentColumn?.field == stateManager.columns.last.field;
  }

  // Moves to the first column in the next row
  void _moveToNextRowFirstColumn(PlutoGridStateManager stateManager) async {
    // Add new Row if we at the end of table
    _addNewRow(stateManager);

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

  void _addNewRow(PlutoGridStateManager stateManager) {
    if (stateManager.currentRow == stateManager.rows.last) {
      stateManager.appendNewRows(count: 1);
    }
  }

  // Moves horizontally to the right within the same row
  void _moveRight(PlutoGridStateManager stateManager) {
    stateManager.moveCurrentCell(PlutoMoveDirection.right, force: true);
  }
}
