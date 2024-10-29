import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';

import 'package:ngu_app/app/lang/localization_service.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/account_option_menu.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomAccountPlutoTable extends StatelessWidget {
  final List<AccountEntity> accounts;

  const CustomAccountPlutoTable({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.55,
      margin: const EdgeInsets.all(Dimensions.primaryPadding),
      child: CustomPlutoTable(
        controller: PlutoGridController(),
        mode: PlutoGridMode.readOnly,
        noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
        columns: _buildColumns(context),
        rows: _buildRows().toList(),
        onLoaded: (PlutoGridOnLoadedEvent event) {},
      ),
    );
  }

  List<PlutoColumn> _buildColumns(BuildContext context) {
    return [
      PlutoColumn(
        title: 'code'.tr,
        field: 'code',
        enableFilterMenuItem: true,
        enableContextMenu: false,
        // enableRowDrag: true,
        type: PlutoColumnType.text(),
        renderer: (rendererContext) {
          AccountEntity accountEntity = accounts
              .firstWhere((account) => account.id == rendererContext.row.data);
          return Row(
            children: [
              // _showMenuOption(rendererContext),
              AccountOptionMenu(accountEntity: accountEntity),
              const SizedBox(width: 8),
              Text(rendererContext.cell.value),
            ],
          );
        },
      ),
      PlutoColumn(
        title: 'name'.tr,
        field: 'name',
        enableFilterMenuItem: true,
        enableContextMenu: false,
        width: MediaQuery.sizeOf(context).width * 0.4,
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'balance'.tr,
        field: 'balance',
        enableFilterMenuItem: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
      ),
    ];
  }

  Iterable<PlutoRow> _buildRows() {
    return accounts.map(
      (account) {
        bool isMainAccount = account.accountType == AccountType.main.name;
        String name =
            LocalizationService.isArabic ? account.arName : account.enName;
        return PlutoRow(
          checked: isMainAccount,
          type: PlutoRowTypeGroup(children: FilteredList()),
          data: account.id,
          cells: {
            'code': PlutoCell(value: account.code),
            'name': PlutoCell(value: name),
            'balance': PlutoCell(
                value: isMainAccount ? account.balance.toString() : ''),
          },
        );
      },
    );
  }
}
