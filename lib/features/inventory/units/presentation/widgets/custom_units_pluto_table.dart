import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';

import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomUnitsPlutoTable extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {
      'ar_name': 'قطعة',
      'en_name': 'Pcs',
    },
    {
      'ar_name': 'كيلو',
      'en_name': 'Kg',
    },
    {
      'ar_name': 'لتر',
      'en_name': 'Ltr',
    },
    {
      'ar_name': 'متر',
      'en_name': 'Mtr',
    },
    {
      'ar_name': 'متر مربع',
      'en_name': 'Mtr2',
    },
    {
      'ar_name': 'متر مكعب',
      'en_name': 'Mtr3',
    },
    {
      'ar_name': 'كيلو واط',
      'en_name': 'Kw',
    },
    {
      'ar_name': 'واط',
      'en_name': 'W',
    },
    {
      'ar_name': 'فولت',
      'en_name': 'V',
    },
    {
      'ar_name': 'أمبير',
      'en_name': 'A',
    },
    {
      'ar_name': 'جرام',
      'en_name': 'Gm',
    },
    {
      'ar_name': 'مللي',
      'en_name': 'Ml',
    },
    {
      'ar_name': 'متر مكعب',
      'en_name': 'Mtr3',
    },
    {
      'ar_name': 'متر مكعب',
      'en_name': 'Mtr3',
    },
    {
      'ar_name': 'متر مكعب',
      'en_name': 'Mtr3',
    },
    {
      'ar_name': 'متر مكعب',
      'en_name': 'Mtr3',
    },
    {
      'ar_name': 'متر مكعب',
      'en_name': 'Mtr3',
    },
    {
      'ar_name': 'متر مكعب',
      'en_name': 'Mtr3',
    },
    {
      'ar_name': 'متر مكعب',
      'en_name': 'Mtr3',
    },
    {
      'ar_name': 'متر مكعب',
      'en_name': 'Mtr3',
    },
  ];
  late PlutoGridController _plutoGridController = PlutoGridController();

  CustomUnitsPlutoTable({
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
          },
        );
      },
    );
  }
}
