import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ngu_app/app/config/constant.dart';
import 'package:ngu_app/core/widgets/custom_expansion_tile.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/custom_section_body.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/custom_section_title.dart';
import 'package:ngu_app/core/widgets/list_tile/basic_list_tile.dart';

class AccountsSection extends StatelessWidget {
  const AccountsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: Column(
        children: [
          CustomSectionTitle(
              title: 'accounting'.tr, icon: Icons.account_balance),
          CustomSectionBody(
            children: [
              CustomExpansionTile(
                title: 'accounts_record'.tr,
                icon: Icons.badge,
                children: [
                  BasicListTile(title: 'account_record'.tr, icon: Icons.badge),
                  BasicListTile(
                      title: 'accounts_tree'.tr, icon: Icons.account_tree),
                  BasicListTile(
                      title: 'accounts_table'.tr, icon: Icons.table_rows),
                  BasicListTile(
                      title: 'accounts_family'.tr, icon: Icons.view_cozy),
                  BasicListTile(
                      title: 'accounts_family_table'.tr,
                      icon: Icons.table_rows),
                  BasicListTile(title: 'opening_voucher'.tr, icon: Icons.grade),
                  BasicListTile(
                      title: 'accounts_setting'.tr, icon: Icons.settings),
                ],
              ),
              // currencies
              CustomExpansionTile(
                title: 'currencies'.tr,
                icon: Icons.money,
                children: [
                  BasicListTile(
                      title: 'currencies_prices'.tr,
                      icon: Icons.currency_exchange),
                  BasicListTile(
                      title: 'currencies_records'.tr, icon: Icons.payment),
                  BasicListTile(title: 'rounding'.tr, icon: Icons.equalizer),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
