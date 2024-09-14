import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/config/constant.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/account_information_card.dart';

class AccountsInformationSidebar extends StatelessWidget {
  const AccountsInformationSidebar({super.key});

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
            subtitle: '123',
          ),
          AccountInformationCard(
            title: 'name'.tr,
            subtitle: 'الموجودات',
          ),
          const Divider(),
          AccountInformationCard(
            title: 'credit_balance'.tr,
            subtitle: '123',
          ),
          AccountInformationCard(
            title: 'debit_balance'.tr,
            subtitle: '321',
          ),
          AccountInformationCard(
            title: 'closing_account_id'.tr,
            subtitle: 'الميزانية',
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
