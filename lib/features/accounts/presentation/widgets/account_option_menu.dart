import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/accounts/presentation/pages/account_record.dart';
import 'package:ngu_app/features/accounts/presentation/pages/create_account.dart';


class AccountOptionMenu extends StatelessWidget {
  final int selectedId;
  const AccountOptionMenu({super.key, required this.selectedId});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'options'.tr,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('add'.tr),
              const Icon(Icons.add_outlined),
            ],
          ),
          onTap: () => _createAccount(context),
        ),
        PopupMenuItem<String>(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('edit'.tr),
              const Icon(Icons.edit_outlined),
            ],
          ),
          onTap: () => _editAccount(context),
        ),
        PopupMenuItem<String>(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('account_sts'.tr),
              const Icon(Icons.info_outline_rounded),
            ],
          ),
        ),
      ],
    );
  }

  _editAccount(BuildContext context) async {
    ShowDialog.showCustomDialog(
        context: context,
        content: AccountRecord(
          accountId: selectedId,
        ),
        height: 0.6);
  }

  _createAccount(BuildContext context) {
    ShowDialog.showCustomDialog(
        context: context,
        content: CreateAccount(
          parentAccountId: selectedId,
        ),
        width: 0.4,
        height: 0.5);
  }
}
