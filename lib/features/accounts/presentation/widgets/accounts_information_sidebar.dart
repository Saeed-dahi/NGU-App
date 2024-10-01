import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/account_information_card.dart';

class AccountsInformationSidebar extends StatelessWidget {
  final AccountEntity account;
  const AccountsInformationSidebar({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimensions.primaryPadding),
      child: Column(
        children: [
          Text(
            'account_info'.tr,
            style: const TextStyle(fontSize: Dimensions.primaryTextSize),
          ),
          AccountInformationCard(
            title: 'code'.tr,
            subtitle: account.code,
          ),
          AccountInformationCard(
            title: 'ar_name'.tr,
            subtitle: account.arName,
          ),
          AccountInformationCard(
            title: 'en_name'.tr,
            subtitle: account.enName,
          ),
          const Divider(),
          AccountInformationCard(
            title: 'credit_balance'.tr,
            subtitle: account.balance.toString(),
          ),
          AccountInformationCard(
            title: 'closing_account_id'.tr,
            subtitle: account.closingAccountId.toString(),
          ),
          const Divider(),
          AccountInformationCard(
            title: 'address'.tr,
            subtitle: 'دبي',
          ),
          AccountInformationCard(
            title: 'phone'.tr,
            subtitle: '060123345',
          ),
          AccountInformationCard(
            title: 'description'.tr,
            subtitle: 'حساب زين زيادة',
          ),
        ],
      ),
    );
  }
}
