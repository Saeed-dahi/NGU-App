import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/cubit/pluto_grid_cubit.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

// ignore: must_be_immutable
class CustomPlutoTable extends StatelessWidget {
  final PlutoGridMode mode;
  final PlutoGridConfiguration? configuration;
  final void Function(PlutoGridOnLoadedEvent)? onLoaded;
  final void Function(PlutoGridOnChangedEvent)? onChanged;
  void Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final List<PlutoColumn> columns;
  final List<PlutoRow> rows;
  final Widget? noRowsWidget;
  final PlutoGridController controller;
  final bool showDefaultHeader;
  final Widget customHeader;

  CustomPlutoTable(
      {super.key,
      required this.columns,
      required this.rows,
      required this.mode,
      required this.onLoaded,
      required this.controller,
      this.onRowDoubleTap,
      this.configuration,
      this.noRowsWidget,
      this.onChanged,
      this.customHeader = const SizedBox(),
      this.showDefaultHeader = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlutoGridCubit(),
      child: BlocBuilder<PlutoGridCubit, OnChangeState>(
        builder: (context, state) {
          return PlutoGrid(
            onLoaded: onLoaded,
            columns: columns,
            rows: rows,
            mode: mode,
            configuration: configuration ?? _tableConfig(),
            onChanged: (event) {
              onChanged!(event);
              context.read<PlutoGridCubit>().onChangeFunction();
            },
            onRowDoubleTap: onRowDoubleTap,
            noRowsWidget: noRowsWidget,
            createHeader: (stateManager) {
              return showDefaultHeader
                  ? _createHeader(stateManager, context)
                  : const SizedBox();
            },
          );
        },
      ),
    );
  }

  Widget _createHeader(stateManager, BuildContext context) {
    controller.setStateManager = stateManager;
    return Row(
      children: [
        customHeader,
        Visibility(
          child: Row(
            children: [
              CustomIconButton(
                icon: Icons.repeat,
                tooltip: '${'repeat'.tr} ${'row'.tr} ${'previous'.tr} ',
                onPressed: () {
                  controller.repeatPreviousRow(controller.stateManager!);
                },
              ),
              CustomIconButton(
                icon: Icons.repeat_one,
                tooltip: '${'repeat'.tr} ${'column'.tr} ${'previous'.tr} ',
                onPressed: () {
                  controller.repeatPreviousColumn(controller.stateManager!);
                },
              ),
              CustomIconButton(
                icon: Icons.insert_drive_file_outlined,
                tooltip: '${'insert'.tr} ${'row'.tr}',
                onPressed: () {
                  controller.appendNewRow(controller.stateManager!);
                },
              ),
              CustomIconButton(
                icon: Icons.delete_forever,
                tooltip: '${'delete'.tr} ${'row'.tr}',
                onPressed: () {
                  controller.removeCurrentRow(controller.stateManager!);
                  context.read<PlutoGridCubit>().onChangeFunction();
                },
              ),
            ],
          ),
        ),
      ],
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
