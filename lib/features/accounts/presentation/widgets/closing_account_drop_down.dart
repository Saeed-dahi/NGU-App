import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_entity.dart';

class ClosingAccountDropDown extends StatefulWidget {
  final List<ClosingAccountEntity> closingAccounts;
  final bool enableEditing;
  final int value;
  final ValueChanged<int?> onChanged;
  const ClosingAccountDropDown(
      {super.key,
      required this.closingAccounts,
      required this.enableEditing,
      required this.onChanged,
      required this.value});

  @override
  State<ClosingAccountDropDown> createState() => _ClosingAccountDropDownState();
}

class _ClosingAccountDropDownState extends State<ClosingAccountDropDown> {
  late List<String> closingAccountNamesList;
  @override
  void initState() {
    closingAccountNamesList = widget.closingAccounts.map((account) {
      return Get.locale == const Locale('en') ? account.enName : account.arName;
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: DropdownButtonFormField(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          items: widget.closingAccounts.map(
            (item) {
              return DropdownMenuItem(
                value: item.id,
                enabled: widget.enableEditing,
                child: Text(
                  Get.locale == const Locale('en') ? item.enName : item.arName,
                  style: TextStyle(
                      color:
                          widget.enableEditing ? AppColors.black : Colors.grey),
                ),
              );
            },
          ).toList(),
          value: widget.value,
          focusColor: AppColors.transparent,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabled: widget.enableEditing,
            helperText: 'closing_account_id'.tr,
            // icon: Text(helper),
            hintStyle: const TextStyle(fontSize: Dimensions.primaryTextSize),
          ),
          onChanged: widget.onChanged),
    );
  }
}
