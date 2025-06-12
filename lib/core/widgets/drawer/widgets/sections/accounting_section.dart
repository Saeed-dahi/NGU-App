import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_expansion_tile.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';

import 'package:ngu_app/core/widgets/lists_tile/basic_list_tile.dart';
import 'package:ngu_app/features/accounts/presentation/pages/account_record.dart';
import 'package:ngu_app/features/accounts/presentation/pages/accounts_table.dart';
import 'package:ngu_app/features/accounts/presentation/pages/accounts_tree.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/account_statement_dialog.dart';
import 'package:ngu_app/features/cheques/presentation/pages/cheque_record.dart';
import 'package:ngu_app/features/cheques/presentation/pages/cheques_table_page.dart';
import 'package:ngu_app/features/closing_accounts/presentation/pages/closing_account_record.dart';

import 'package:ngu_app/features/closing_accounts/presentation/widgets/closing_account_statement_dialog.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';
import 'package:ngu_app/features/journals/presentation/pages/journal_vouchers.dart';

class AccountingSection extends StatelessWidget {
  final bool initiallyExpanded;

  const AccountingSection({super.key, this.initiallyExpanded = false});

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
            initiallyExpanded: initiallyExpanded,
            children: [
              _buildAccountsRecord(context),
              _buildVouchers(context),
              _detailedReports(context),
              _cheques(context),
              _totalReports(context),
              _currencies(),
              _closingVouchers(context),
              _adjustmentNote(context)
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
          title: '${'process'.tr} ${'closing_vouchers'.tr}',
          icon: Icons.payment_outlined,
          onTap: () => ShowDialog.showCustomDialog(
              width: 0.2,
              height: 0.2,
              content: ClosingAccountStatementDialog(),
              context: context),
        ),
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
              content: const AccountStatementDialog(),
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

  CustomExpansionTile _cheques(BuildContext context) {
    return CustomExpansionTile(
      title: 'post_dated_cheques'.tr,
      icon: Icons.money,
      children: [
        BasicListTile(
            title: 'cheque_card'.tr,
            image: Image.asset('assets/images/cheque.png', width: 30),
            onTap: () => ShowDialog.showCustomDialog(
                height: 0.55,
                width: 0.7,
                content: const ChequeRecord(),
                context: context)),
        BasicListTile(
          title: 'cheques_table'.tr,
          icon: Icons.table_chart_outlined,
          onTap: () => context.read<TabCubit>().addNewTab(
              content: const ChequesTablePage(), title: 'cheques_table'.tr),
        ),
      ],
    );
  }

  CustomExpansionTile _adjustmentNote(BuildContext context) {
    return CustomExpansionTile(
      title: 'adjustment_note'.tr,
      icon: Icons.note_alt_sharp,
      children: [
        BasicListTile(
            title: 'credit_note'.tr,
            image: Image.asset('assets/images/credit_note.png', width: 30),
            onTap: () => ShowDialog.showCustomDialog(
                height: 0.55,
                width: 0.7,
                content: const ChequeRecord(),
                context: context)),
        BasicListTile(
          title: 'credit_notes_table'.tr,
          icon: Icons.table_chart_outlined,
          onTap: () => context.read<TabCubit>().addNewTab(
              content: const ChequesTablePage(), title: 'cheques_table'.tr),
        ),
        const Divider(
          color: AppColors.primaryColor,
        ),
        BasicListTile(
            title: 'debit_note'.tr,
            image: Image.asset('assets/images/debit_note.png', width: 30),
            onTap: () => ShowDialog.showCustomDialog(
                height: 0.55,
                width: 0.7,
                content: const ChequeRecord(),
                context: context)),
        BasicListTile(
          title: 'debit_notes_table'.tr,
          icon: Icons.table_chart_outlined,
          onTap: () => context.read<TabCubit>().addNewTab(
              content: const ChequesTablePage(), title: 'cheques_table'.tr),
        ),
      ],
    );
  }
}
