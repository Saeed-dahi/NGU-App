import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';

import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';

import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';
import 'package:ngu_app/features/accounts/presentation/pages/account_record.dart';
import 'package:ngu_app/features/accounts/presentation/pages/create_account.dart';
import 'package:ngu_app/features/closing_accounts/presentation/bloc/closing_accounts_bloc.dart';

import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class AccountsTable extends StatelessWidget {
  late PlutoGridStateManager stateManager;
  final TextEditingController searchController = TextEditingController();

  AccountsTable({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        if (state is GetAllAccountsState) {
          if (state.accounts.isNotEmpty) {
            return RefreshIndicator(
                onRefresh: () => _refresh(context),
                child: _pageBody(context, state));
          } else {
            return Center(
              child: MessageScreen(text: AppStrings.notFound.tr),
            );
          }
        }
        if (state is ErrorAccountsState) {
          return Center(
            child: MessageScreen(text: state.message),
          );
        }
        return Center(
          child: Loaders.loading(),
        );
      },
    );
  }

  ListView _pageBody(BuildContext context, GetAllAccountsState state) {
    return ListView(
      children: [
        CustomInputField(
          inputType: TextInputType.text,
          label: 'search'.tr,
          controller: searchController,
          onChanged: (value) => _applyFilters(value!),
        ),
        Container(
          height: MediaQuery.sizeOf(context).height * 0.55,
          margin: const EdgeInsets.all(Dimensions.primaryPadding),
          child: PlutoGrid(
            configuration: _tableConfig(),
            onRowDoubleTap: (event) => _editAccount(context, event),
            onRowSecondaryTap: (event) => _createAccount(context, event),
            mode: PlutoGridMode.readOnly,
            columns: _buildColumns(context),
            rows: _buildRows(state).toList(),
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
              _showMenuOption(rendererContext),
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

  Iterable<PlutoRow> _buildRows(GetAllAccountsState state) {
    return flattenAccounts(state.accounts).map(
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

  List<AccountEntity> flattenAccounts(List<AccountEntity> accounts) {
    List<AccountEntity> allAccounts = [];
    for (var account in accounts) {
      allAccounts.add(account); // Add the main account
      if (account.subAccounts.isNotEmpty) {
        allAccounts.addAll(flattenAccounts(
            account.subAccounts)); // Recursively add sub-accounts
      }
    }
    return allAccounts;
  }

  void _applyFilters(String searchValue) {
    stateManager.setFilter(
      (row) {
        final name = row.cells['name']!.value.toString().toLowerCase();
        final code = row.cells['code']!.value.toString();

        return name.contains(searchValue.toLowerCase()) ||
            code.contains(searchValue);
      },
    );
  }

  Widget _showMenuOption(event) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: Text('add'.tr),
          onTap: () => _createAccount(context, event),
        ),
        PopupMenuItem<String>(
          child: Text('edit'.tr),
          onTap: () => _editAccount(context, event),
        ),
        PopupMenuItem<String>(
          child: Text('statement'.tr),
        ),
      ],
    );
  }

  _editAccount(BuildContext context, event) async {
    ShowDialog.showCustomDialog(
        context: context,
        content: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<AccountsBloc>()
                ..add(ShowAccountsEvent(accountId: event.row.data)),
            ),
            BlocProvider(
              create: (context) =>
                  sl<ClosingAccountsBloc>()..add(GetAllClosingAccountsEvent()),
            ),
          ],
          child: const AccountRecord(),
        ),
        height: 0.6);
  }

  void _createAccount(BuildContext context, event) {
    ShowDialog.showCustomDialog(
        context: context,
        content: BlocProvider(
          create: (context) => sl<AccountsBloc>()
            ..add(GetSuggestionCodeEvent(parentId: event.row.data)),
          child: CreateAccount(
            parentAccountId: event.row.data,
          ),
        ),
        width: 0.4,
        height: 0.5);
  }

  Future<void> _refresh(BuildContext context) async {
    context.read<AccountsBloc>().add(GetAllAccountsEvent());
  }
}
