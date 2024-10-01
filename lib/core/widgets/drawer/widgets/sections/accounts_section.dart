import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_expansion_tile.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/custom_section_body.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/custom_section_title.dart';
import 'package:ngu_app/core/widgets/lists_tile/basic_list_tile.dart';
import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';
import 'package:ngu_app/features/accounts/presentation/pages/account_record.dart';
import 'package:ngu_app/features/accounts/presentation/pages/accounts_table.dart';
import 'package:ngu_app/features/accounts/presentation/pages/accounts_tree.dart';
import 'package:ngu_app/features/closing_accounts/presentation/bloc/closing_accounts_bloc.dart';
import 'package:ngu_app/features/closing_accounts/presentation/pages/closing_account_record.dart';
import 'package:ngu_app/features/home/presentation/cubit/tab_cubit.dart';

class AccountsSection extends StatelessWidget {
  const AccountsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: Column(
        children: [
          CustomSectionTitle(
              title: 'accounting'.tr, icon: Icons.account_balance_outlined),
          CustomSectionBody(
            children: [
              _buildAccountsRecord(context),
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
              content: BlocProvider(
                create: (context) => sl<ClosingAccountsBloc>()
                  ..add(const ShowClosingsAccountsEvent(accountId: 1)),
                child: const ClosingAccountRecord(),
              ),
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
              content: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => sl<AccountsBloc>()
                      ..add(const ShowAccountsEvent(accountId: 1)),
                  ),
                  BlocProvider(
                    create: (context) => sl<ClosingAccountsBloc>()
                      ..add(GetAllClosingAccountsEvent()),
                  ),
                ],
                child: const AccountRecord(),
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
              content: BlocProvider(
                create: (context) =>
                    sl<AccountsBloc>()..add(GetAllAccountsEvent()),
                child: AccountsTable(),
              ),
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
}
