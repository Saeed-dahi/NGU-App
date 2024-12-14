import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_auto_complete.dart';
import 'package:ngu_app/core/widgets/custom_expansion_tile.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/lists_tile/basic_list_tile.dart';
import 'package:ngu_app/features/accounts/presentation/pages/account_record.dart';
import 'package:ngu_app/features/accounts/presentation/pages/account_statement.dart';

import 'package:ngu_app/features/accounts/presentation/pages/accounts_table.dart';
import 'package:ngu_app/features/accounts/presentation/pages/accounts_tree.dart';
import 'package:ngu_app/features/closing_accounts/presentation/pages/closing_account_record.dart';
import 'package:ngu_app/features/home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';
import 'package:ngu_app/features/journals/presentation/pages/journal_vouchers.dart';

class AccountingSection extends StatefulWidget {
  final bool initiallyExpanded;

  const AccountingSection({super.key, this.initiallyExpanded = false});

  @override
  State<AccountingSection> createState() => _AccountingSectionState();
}

class _AccountingSectionState extends State<AccountingSection> {
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    _homeCubit = sl<HomeCubit>()..getAccountsName();
    super.initState();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: Column(
        children: [
          CustomExpansionTile(
            title: 'accounting'.tr,
            icon: Icons.account_balance_outlined,
            backgroundColor: const Color.fromARGB(90, 0, 0, 0),
            activeColor: AppColors.white,
            initiallyExpanded: widget.initiallyExpanded,
            children: [
              _buildAccountsRecord(context),
              _buildVouchers(context),
              _detailedReports(context),
              _totalReports(context),
              _currencies(),
              _closingVouchers(context)
            ],
          ),
        ],
      ),
    );
  }

  CustomExpansionTile _closingVouchers(BuildContext context) {
    return CustomExpansionTile(
      title: 'closing_vouchers'.tr,
      icon: Icons.assignment_turned_in_outlined,
      children: [
        BasicListTile(
          title: 'closing_accounts'.tr,
          icon: Icons.monetization_on_outlined,
          onTap: () => ShowDialog.showCustomDialog(
              context: context,
              content: const ClosingAccountRecord(),
              height: 0.4),
        ),
        BasicListTile(
            title: 'profit_and_loss'.tr, icon: Icons.payment_outlined),
      ],
    );
  }

  CustomExpansionTile _currencies() {
    return CustomExpansionTile(
      title: 'currencies'.tr,
      icon: Icons.money,
      children: [
        BasicListTile(
            title: 'currencies_prices'.tr,
            icon: Icons.currency_exchange_outlined),
        BasicListTile(
            title: 'currencies_records'.tr, icon: Icons.payment_outlined),
        BasicListTile(title: 'rounding'.tr, icon: Icons.equalizer_outlined),
      ],
    );
  }

  CustomExpansionTile _buildAccountsRecord(BuildContext context) {
    return CustomExpansionTile(
      title: 'accounts_record'.tr,
      icon: Icons.badge_outlined,
      children: [
        BasicListTile(
          title: 'account_record'.tr,
          icon: Icons.badge_outlined,
          onTap: () => ShowDialog.showCustomDialog(
              context: context,
              height: 0.6,
              content: const AccountRecord(
                accountId: 1,
              )),
        ),
        BasicListTile(
          title: 'accounts_tree'.tr,
          icon: Icons.account_tree_outlined,
          onTap: () {
            context.read<TabCubit>().addNewTab(
                title: 'accounts_tree'.tr, content: const AccountsTree());
          },
        ),
        BasicListTile(
          title: 'accounts_table'.tr,
          icon: Icons.table_rows_outlined,
          onTap: () {
            ShowDialog.showCustomDialog(
              width: 0.7,
              context: context,
              content: const AccountsTable(),
            );
          },
        ),
        BasicListTile(
            title: 'accounts_family'.tr, icon: Icons.view_cozy_outlined),
        BasicListTile(
            title: 'accounts_family_table'.tr, icon: Icons.table_rows_outlined),
        BasicListTile(title: 'opening_voucher'.tr, icon: Icons.grade_outlined),
        BasicListTile(
            title: 'accounts_setting'.tr, icon: Icons.settings_outlined),
      ],
    );
  }

  CustomExpansionTile _buildVouchers(BuildContext context) {
    return CustomExpansionTile(
        title: 'vouchers'.tr,
        icon: Icons.menu_book_outlined,
        children: [
          BasicListTile(
            title: 'journal_vouchers'.tr,
            icon: Icons.menu_book_outlined,
            onTap: () => context.read<TabCubit>().addNewTab(
                title: 'journal_vouchers'.tr, content: const JournalVouchers()),
          ),
          BasicListTile(
              title: 'journal_vouchers_table'.tr,
              icon: Icons.table_chart_outlined),
        ]);
  }

  CustomExpansionTile _detailedReports(BuildContext context) {
    return CustomExpansionTile(
      title: '${'reports'.tr} ${'detailed'.tr} ',
      icon: Icons.library_books,
      children: [
        BasicListTile(
          title: 'account_sts'.tr,
          icon: Icons.article,
          onTap: () => ShowDialog.showCustomDialog(
              width: 0.2,
              height: 0.2,
              content: CustomAutoComplete(
                data: _homeCubit.accountsNameList,
                label: 'account',
                onSelected: (value) {
                  var spitedValue = value.split('-');
                  var desiredId = int.parse(_homeCubit.accountsNameMap[
                      'id_${spitedValue[0].removeAllWhitespace}']);
                  Get.back();
                  context.read<TabCubit>().addNewTab(
                      content: AccountStatementPage(accountId: desiredId),
                      title:
                          '${'account_sts'.tr} (${spitedValue[1]} - ${spitedValue[2]})');
                },
              ),
              context: context),
        ),
        BasicListTile(
            title: '${'reports'.tr} ${'journals'.tr}',
            icon: Icons.payment_outlined),
      ],
    );
  }

  CustomExpansionTile _totalReports(BuildContext context) {
    return CustomExpansionTile(
      title: '${'reports'.tr} ${'total'.tr} ',
      icon: Icons.library_books,
      children: [
        BasicListTile(
          title: 'trail_balance'.tr,
          icon: Icons.balance_outlined,
        ),
      ],
    );
  }
}
