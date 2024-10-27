import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';

import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/lang/localization_service.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';

import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomJournalVouchersPlutoTable extends StatelessWidget {
  CustomJournalVouchersPlutoTable({super.key});
  List<PlutoRow> rows = [];
  late final PlutoGridStateManager _stateManger;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        _buildHeader(context),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.65,
          child: PlutoGrid(
            configuration: _tableConfig(),
            onLoaded: (event) {
              _stateManger = event.stateManager;
            },
            // noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
            columns: _buildColumns(),
            rows: _buildRows(),
          ),
        ),
      ],
    );
  }

  List<PlutoColumn> _buildColumns() {
    return [
      _buildCustomColumn('debit', PlutoColumnType.number()),
      _buildCustomColumn('credit', PlutoColumnType.number()),
      _buildCustomColumn('account_code', PlutoColumnType.number()),
      _buildCustomColumn('account_name', PlutoColumnType.number()),
      _buildCustomColumn('description', PlutoColumnType.text()),
      _buildCustomColumn('document_number', PlutoColumnType.text()),
    ];
  }

  List<PlutoRow> _buildRows() {
    rows.add(PlutoRow(
      sortIdx: 0,
      cells: {
      'debit': PlutoCell(value: null),
      'credit': PlutoCell(value: ''),
      'account_code': PlutoCell(value: ''),
      'account_name': PlutoCell(value: ''),
      'description': PlutoCell(value: ''),
      'document_number': PlutoCell(value: ''),
    }));

    return rows;
  }

  PlutoGridConfiguration _tableConfig() {
    return PlutoGridConfiguration(
      localeText: LocalizationService.isArabic
          ? const PlutoGridLocaleText.arabic()
          : const PlutoGridLocaleText(),
      columnFilter: const PlutoGridColumnFilterConfig(),
      scrollbar: const PlutoGridScrollbarConfig(
          scrollBarColor: AppColors.primaryColor),
      columnSize: const PlutoGridColumnSizeConfig(
          autoSizeMode: PlutoAutoSizeMode.scale),
      tabKeyAction: PlutoGridTabKeyAction.moveToNextOnEdge,
      style: PlutoGridStyleConfig(
        rowCheckedColor: AppColors.primaryColorLow.withOpacity(0.3),
        gridBorderColor: AppColors.primaryColor,
        rowHoveredColor: AppColors.transparent,
        enableGridBorderShadow: true,
        enableRowHoverColor: true,
        gridBorderRadius: BorderRadius.circular(
          Dimensions.borderRadius,
        ),
      ),
    );
  }

  PlutoColumn _buildCustomColumn(String title, PlutoColumnType type) {
    return PlutoColumn(
        title: title.tr,
        field: title,
        type: type,
        enableAutoEditing: true,
        applyFormatterInEditing: true,
        textAlign: PlutoColumnTextAlign.center,
        enableEditingMode: true,
        enableSorting: false,
        enableContextMenu: false,
        enableFilterMenuItem: false);
  }

  _buildHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.2,
              child: CustomInputField(
                inputType: TextInputType.text,
                label: 'code'.tr,
                onTap: () {
                  _stateManger.appendNewRows(count: 10);
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.2,
              child: CustomInputField(
                inputType: TextInputType.text,
                label: 'document_number'.tr,
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.2,
              child: CustomDatePicker(
                  dateInput: TextEditingController(),
                  labelText: 'created_at'.tr),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.2,
              child: CustomInputField(
                inputType: TextInputType.text,
                label: 'description'.tr,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
