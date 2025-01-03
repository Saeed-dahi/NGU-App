import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';

import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomStoresPlutoTable extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {
      'id': 1,
      'description': '',
      'ar_name': 'المستودع ١',
      'en_name': 'Store 1',
    },
    {
      'id': 2,
      'description': '',
      'ar_name': 'المستودع ٢',
      'en_name': 'Store 2',
    },
    {
      'id': 3,
      'description': '',
      'ar_name': 'المستودع ٣',
      'en_name': 'Store 3',
    },
    {
      'id': 4,
      'description': '',
      'ar_name': 'المستودع ٤',
      'en_name': 'Store 4',
    },
    {
      'id': 5,
      'description': '',
      'ar_name': 'المستودع ٥',
      'en_name': 'Store 5',
    },
  ];
  late PlutoGridController _plutoGridController = PlutoGridController();

  CustomStoresPlutoTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.55,
      margin: const EdgeInsets.all(Dimensions.primaryPadding),
      child: CustomPlutoTable(
        controller: _plutoGridController,
        mode: PlutoGridMode.readOnly,
        noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
        columns: _buildColumns(context),
        rows: _buildRows().toList(),
        showDefaultHeader: false,
        onLoaded: (PlutoGridOnLoadedEvent event) {
          _plutoGridController =
              PlutoGridController(stateManager: event.stateManager);
        },
      ),
    );
  }

  List<PlutoColumn> _buildColumns(BuildContext context) {
    return [
      PlutoColumn(
        title: 'ar_name'.tr,
        field: 'ar_name',
        enableFilterMenuItem: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'en_name'.tr,
        field: 'en_name',
        enableFilterMenuItem: true,
        enableContextMenu: false,
        width: MediaQuery.sizeOf(context).width * 0.4,
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'description'.tr,
        field: 'description',
        enableFilterMenuItem: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
      ),
    ];
  }

  _buildRows() {
    return data.map(
      (account) {
        return PlutoRow(
          type: PlutoRowTypeGroup(children: FilteredList()),
          data: account['id'],
          cells: {
            'ar_name': PlutoCell(value: account['ar_name']),
            'en_name': PlutoCell(value: account['en_name']),
            'description': PlutoCell(value: account['description']),
          },
        );
      },
    );
  }
}
