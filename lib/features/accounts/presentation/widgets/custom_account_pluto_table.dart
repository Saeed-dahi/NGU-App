import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';

import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/option_menu.dart';

import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomAccountPlutoTable extends StatelessWidget {
  final List<AccountEntity> accounts;
  late PlutoGridStateManager stateManager;
  final TextEditingController searchController = TextEditingController();
  CustomAccountPlutoTable({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomInputField(
          inputType: TextInputType.text,
          label: 'search'.tr,
          controller: searchController,
          onChanged: (value) => context.read<AccountsBloc>().add(
              SearchInAccountsEvent(query: value, stateManager: stateManager)),
        ),
        Container(
          height: MediaQuery.sizeOf(context).height * 0.55,
          margin: const EdgeInsets.all(Dimensions.primaryPadding),
          child: PlutoGrid(
            configuration: _tableConfig(),
            mode: PlutoGridMode.readOnly,
            columns: _buildColumns(context),
            rows: _buildRows().toList(),
            onLoaded: (PlutoGridOnLoadedEvent event) {
              stateManager = event.stateManager;
            },
          ),
        ),
      ],
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
          return Row(
            children: [
              // _showMenuOption(rendererContext),
              OptionMenu(event: rendererContext),
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
        return PlutoRow(
          checked: account.subAccounts.isNotEmpty,
          type: PlutoRowTypeGroup(children: FilteredList()),
          data: account.id,
          cells: {
            'code': PlutoCell(value: account.code),
            'name': PlutoCell(value: account.arName),
            'balance': PlutoCell(
                value: account.subAccounts.isNotEmpty
                    ? account.balance.toString()
                    : ''),
          },
        );
      },
    );
  }

  PlutoGridConfiguration _tableConfig() {
    return PlutoGridConfiguration(
      localeText: Get.locale == const Locale('ar')
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
        enableGridBorderShadow: true,
        enableRowHoverColor: true,
        gridBorderRadius: BorderRadius.circular(
          Dimensions.borderRadius,
        ),
      ),
    );
  }
}
