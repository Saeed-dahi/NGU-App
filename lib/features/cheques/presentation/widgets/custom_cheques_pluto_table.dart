import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomChequesPlutoTable extends StatelessWidget {
  late PlutoGridController _plutoGridController = PlutoGridController();

  CustomChequesPlutoTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.8,
      margin: const EdgeInsets.all(Dimensions.primaryPadding),
      child: CustomPlutoTable(
        controller: _plutoGridController,
        mode: PlutoGridMode.readOnly,
        noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
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
        title: 'debit'.tr,
        field: 'debit',
        type: PlutoColumnType.text(),
        footerRenderer: (context) {
          return const Center(
            child: Text(
              '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
      PlutoColumn(
          title: 'credit'.tr,
          field: 'credit',
          type: PlutoColumnType.text(),
          footerRenderer: (context) {
            return const Center(
              child: Text(
                '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }),
      PlutoColumn(
          title: 'balance'.tr,
          field: 'account_new_balance',
          type: PlutoColumnType.text(),
          footerRenderer: (context) {
            return Center(
              child: Text(
                '${'balance'.tr}: ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }),
      PlutoColumn(
        title: 'description'.tr,
        field: 'description',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'document_number'.tr,
        field: 'document_number',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'created_at'.tr,
        field: 'created_at',
        type: PlutoColumnType.date(),
      ),
    ];
  }

  Iterable<PlutoRow> _buildRows() {
    return [].map(
      (sts) {
        return PlutoRow(
          type: PlutoRowTypeGroup(children: FilteredList()),
          data: sts.id,
          cells: {
            'debit': PlutoCell(
                value: sts.type == AccountNature.debit.name ? sts.amount : ''),
            'credit': PlutoCell(
                value: sts.type == AccountNature.credit.name ? sts.amount : ''),
            'account_new_balance': PlutoCell(value: sts.accountNewBalance),
            'description': PlutoCell(value: sts.description),
            'document_number': PlutoCell(value: sts.documentNumber),
            'created_at': PlutoCell(value: sts.date),
          },
        );
      },
    );
  }
}
