import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';

import 'package:ngu_app/features/closing_accounts/domain/entities/custom_account_entity.dart';

import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomClosingAccountPlutoTableStatement extends StatelessWidget {
  late PlutoGridController _plutoGridController = PlutoGridController();

  final List<CustomAccountEntity> accounts;
  final double accountsValue;
  CustomClosingAccountPlutoTableStatement(
      {super.key, required this.accounts, required this.accountsValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.85,
      margin: const EdgeInsets.all(Dimensions.primaryPadding),
      child: CustomPlutoTable(
        controller: _plutoGridController,
        mode: PlutoGridMode.readOnly,
        columns: _buildColumns(context),
        rows: _buildRows().toList(),
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
        title: 'code'.tr,
        field: 'code',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'name'.tr,
        field: 'name',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
          title: 'balance'.tr,
          field: 'balance',
          type: PlutoColumnType.text(),
          footerRenderer: (context) {
            return Center(
              child: Text(
                accountsValue.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }),
    ];
  }

  _buildRows() {
    return accounts.map(
      (account) {
        return PlutoRow(
          type: PlutoRowTypeGroup(children: FilteredList()),
          data: account.id,
          cells: {
            'code': PlutoCell(value: account.code),
            'name': PlutoCell(value: account.arName),
            'balance': PlutoCell(value: account.balance),
          },
        );
      },
    );
  }
}
