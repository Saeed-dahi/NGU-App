import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/config/constant.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/accounts_toolbar.dart';

class AccountRecord extends StatelessWidget {
  final bool enableEditing = false;
  const AccountRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Text(
            'account_record'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: Dimensions.primaryTextSize),
          ),
          const SizedBox(
            height: 10,
          ),
          const AccountsToolbar(),
          TabBar(
            labelColor: Colors.black,
            indicatorColor: AppColors.primaryColor,
            tabs: [
              Tab(text: 'account'.tr),
              Tab(text: 'account_info'.tr),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // General Account info
                accountBasicInfo(context),
                accountDetailsInfo(context),
                // all Account information
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView accountBasicInfo(BuildContext context) {
    return ListView(
      children: [
        Wrap(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: CustomInputField(
                inputType: TextInputType.name,
                enabled: enableEditing,
                helper: 'en_name'.tr,
                controller: TextEditingController(text: 'Assets'),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: CustomInputField(
                inputType: TextInputType.name,
                enabled: enableEditing,
                helper: 'ar_name'.tr,
                controller: TextEditingController(text: 'الموجودات'),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: CustomInputField(
                inputType: TextInputType.name,
                enabled: enableEditing,
                controller: TextEditingController(text: '123'),
                helper: 'code'.tr,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: CustomInputField(
                inputType: TextInputType.name,
                enabled: enableEditing,
                controller: TextEditingController(text: '24323234'),
                helper: 'balance'.tr,
              ),
            ),
          ],
        ),
        CustomInputField(
          inputType: TextInputType.name,
          enabled: enableEditing,
          helper: 'description'.tr,
          controller: TextEditingController(text: ''),
        ),
        Row(
          children: [
            CustomDropdown(
              dropdownValue: getEnumValues(AccountCategory.values),
              enabled: enableEditing,
              helper: 'account_type'.tr,
              value: 'equity',
              // value: 's',
            ),
            const SizedBox(
              width: 8,
            ),
            CustomDropdown(
              dropdownValue: getEnumValues(AccountNature.values),
              enabled: enableEditing,
              helper: 'account_nature'.tr,
            ),
            const SizedBox(
              width: 8,
            ),
            CustomDropdown(
              dropdownValue: getEnumValues(AccountCategory.values),
              enabled: enableEditing,
              helper: 'closing_account_id'.tr,
              // value: AccountCategory.asset.name,
            ),
          ],
        ),
      ],
    );
  }

  ListView accountDetailsInfo(BuildContext context) {
    return ListView(
      children: [
        Wrap(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: CustomInputField(
                inputType: TextInputType.name,
                enabled: enableEditing,
                helper: 'phone'.tr,
                controller: TextEditingController(text: 'Assets'),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: CustomInputField(
                inputType: TextInputType.name,
                enabled: enableEditing,
                helper: 'email'.tr,
                controller: TextEditingController(text: 'الموجودات'),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: CustomInputField(
                inputType: TextInputType.name,
                enabled: enableEditing,
                controller: TextEditingController(text: '123'),
                helper: 'mobile'.tr,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: CustomInputField(
                inputType: TextInputType.name,
                enabled: enableEditing,
                controller: TextEditingController(text: '24323234'),
                helper: 'fax'.tr,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: CustomInputField(
                inputType: TextInputType.name,
                enabled: enableEditing,
                controller: TextEditingController(text: '24323234'),
                helper: 'contact_person_name'.tr,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: CustomInputField(
                inputType: TextInputType.name,
                enabled: enableEditing,
                controller: TextEditingController(text: '24323234'),
                helper: 'address'.tr,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: CustomInputField(
                inputType: TextInputType.name,
                enabled: enableEditing,
                controller: TextEditingController(text: '24323234'),
                helper: 'barcode'.tr,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: CustomInputField(
                inputType: TextInputType.name,
                enabled: enableEditing,
                controller: TextEditingController(text: '24323234'),
                helper: 'info_in_invoice'.tr,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: CustomInputField(
                inputType: TextInputType.name,
                enabled: enableEditing,
                controller: TextEditingController(text: '24323234'),
                helper: 'file'.tr,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
