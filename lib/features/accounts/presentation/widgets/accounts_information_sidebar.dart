import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/features/accounts/account_information/domain/entities/account_information_entity.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/account_information_card.dart';

class AccountsInformationSidebar extends StatelessWidget {
  final AccountEntity account;
  final AccountInformationEntity accountInformation;
  const AccountsInformationSidebar(
      {super.key, required this.account, required this.accountInformation});

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
            subtitle: accountInformation.closingAccountName!,
          ),
          const Divider(),
          AccountInformationCard(
            title: 'address'.tr,
            subtitle: accountInformation.address!,
          ),
          AccountInformationCard(
            title: 'email'.tr,
            subtitle: accountInformation.email!,
          ),
          AccountInformationCard(
            title: 'phone'.tr,
            subtitle: accountInformation.phone!,
          ),
          AccountInformationCard(
            title: 'description'.tr,
            subtitle: accountInformation.description!,
          ),
        ],
      ),
    );
  }
}
