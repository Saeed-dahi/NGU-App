import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

// ignore: must_be_immutable
class CustomPlutoTable extends StatelessWidget {
  final PlutoGridMode mode;
  final PlutoGridConfiguration? configuration;
  final void Function(PlutoGridOnLoadedEvent)? onLoaded;
  final void Function(PlutoGridOnChangedEvent)? onChanged;
  final List<PlutoColumn> columns;
  final List<PlutoRow> rows;
  final Widget? noRowsWidget;
  final PlutoGridController controller;

  const CustomPlutoTable(
      {super.key,
      required this.columns,
      required this.rows,
      required this.mode,
      required this.onLoaded,
      this.configuration,
      this.noRowsWidget,
      required this.controller,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      onLoaded: onLoaded,
      columns: columns,
      rows: rows,
      mode: mode,
      configuration: configuration ?? _tableConfig(),
      onChanged: onChanged,
      noRowsWidget: noRowsWidget,
    );
  }

  PlutoGridConfiguration _tableConfig() {
    return PlutoGridConfiguration(
      localeText: controller.getLocaleText(),
      shortcut: controller.customArabicGridShortcut(),
      tabKeyAction: PlutoGridTabKeyAction.moveToNextOnEdge,
      enableMoveHorizontalInEditing: true,
      scrollbar: const PlutoGridScrollbarConfig(
          scrollBarColor: AppColors.primaryColor),
      columnSize: const PlutoGridColumnSizeConfig(
          autoSizeMode: PlutoAutoSizeMode.equal),
      style: PlutoGridStyleConfig(
        rowCheckedColor: AppColors.primaryColorLow.withOpacity(0.3),
        gridBorderColor: AppColors.primaryColor,
        rowHoveredColor: AppColors.transparent,
        enableGridBorderShadow: true,
        enableRowHoverColor: true,
        enableCellBorderHorizontal: true,
        gridBorderRadius: BorderRadius.circular(
          Dimensions.borderRadius,
        ),
      ),
    );
  }
}
