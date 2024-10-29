import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ngu_app/app/app_management/app_strings.dart';

import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';

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
          child: CustomPlutoTable(
            controller: PlutoGridController(),
            mode: PlutoGridMode.normal,
            onLoaded: (event) {
              _stateManger = event.stateManager;
              _stateManger.appendNewRows(count: 100);
            },
            noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
            columns: _buildColumns(),
            rows: _buildRows(),
          ),
        ),
      ],
    );
  }

  List<PlutoColumn> _buildColumns() {
    return [
      _buildCustomColumn('debit'),
      _buildCustomColumn('credit'),
      _buildCustomColumn('account_code'),
      _buildCustomColumn('account_name'),
      _buildCustomColumn('description'),
      _buildCustomColumn('document_number'),
    ];
  }

  List<PlutoRow> _buildRows() {
    rows.add(PlutoRow(cells: {
      'debit': PlutoCell(value: ''),
      'credit': PlutoCell(value: ''),
      'account_code': PlutoCell(value: ''),
      'account_name': PlutoCell(value: ''),
      'description': PlutoCell(value: ''),
      'document_number': PlutoCell(value: ''),
    }));

    return rows;
  }

  PlutoColumn _buildCustomColumn(String title) {
    return PlutoColumn(
      title: title.tr,
      field: title,
      type: PlutoColumnType.text(),
      enableAutoEditing: true,
      textAlign: PlutoColumnTextAlign.center,
      enableSorting: false,
      enableContextMenu: false,
      enableFilterMenuItem: false,
    );
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
                onTap: () {},
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
