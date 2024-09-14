import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ngu_app/app/config/constant.dart';
import 'package:ngu_app/core/widgets/custom_expansion_tile.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/custom_section_body.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/custom_section_title.dart';
import 'package:ngu_app/core/widgets/lists_tile/basic_list_tile.dart';
import 'package:ngu_app/features/accounts/presentation/pages/account_record.dart';
import 'package:ngu_app/features/accounts/presentation/pages/accounts_table.dart';
import 'package:ngu_app/features/accounts/presentation/pages/accounts_tree.dart';

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
              CustomExpansionTile(
                title: 'accounts_record'.tr,
                icon: Icons.badge_outlined,
                children: [
                  BasicListTile(
                    title: 'account_record'.tr,
                    icon: Icons.badge_outlined,
                    onTap: () => ShowDialog.showCustomDialog(
                        context: context, content: const AccountRecord()),
                  ),
                  BasicListTile(
                    title: 'accounts_tree'.tr,
                    icon: Icons.account_tree_outlined,
                    onTap: () {
                      Get.to(() => const AccountsTree(title: 'Account tree'));
                    },
                  ),
                  BasicListTile(
                    title: 'accounts_table'.tr,
                    icon: Icons.table_rows_outlined,
                    onTap: () {
                      Get.to(() => const AccountsTable());
                    },
                  ),
                  BasicListTile(
                      title: 'accounts_family'.tr,
                      icon: Icons.view_cozy_outlined),
                  BasicListTile(
                      title: 'accounts_family_table'.tr,
                      icon: Icons.table_rows_outlined),
                  BasicListTile(
                      title: 'opening_voucher'.tr, icon: Icons.grade_outlined),
                  BasicListTile(
                      title: 'accounts_setting'.tr,
                      icon: Icons.settings_outlined),
                ],
              ),
              // currencies
              CustomExpansionTile(
                title: 'currencies'.tr,
                icon: Icons.money,
                children: [
                  BasicListTile(
                      title: 'currencies_prices'.tr,
                      icon: Icons.currency_exchange_outlined),
                  BasicListTile(
                      title: 'currencies_records'.tr,
                      icon: Icons.payment_outlined),
                  BasicListTile(
                      title: 'rounding'.tr, icon: Icons.equalizer_outlined),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
