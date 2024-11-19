import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/presentation/pages/account_record.dart';
import 'package:ngu_app/features/accounts/presentation/pages/account_statement.dart';
import 'package:ngu_app/features/accounts/presentation/pages/create_account.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';

class AccountOptionMenu extends StatelessWidget {
  final AccountEntity accountEntity;
  const AccountOptionMenu({super.key, required this.accountEntity});

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
          onTap: () => _accountStatement(context),
        ),
      ],
    );
  }

  _editAccount(BuildContext context) async {
    ShowDialog.showCustomDialog(
        context: context,
        content: AccountRecord(
          accountId: accountEntity.id!,
        ),
        height: 0.6);
  }

  _createAccount(BuildContext context) {
    ShowDialog.showCustomDialog(
        context: context,
        content: CreateAccount(
          parentAccountId: accountEntity.id,
        ),
        width: 0.4,
        height: 0.5);
  }

  _accountStatement(context) {
    BlocProvider.of<TabCubit>(context).addNewTab(
      title:
          '${'account_sts'.tr} (${accountEntity.enName}-${accountEntity.arName})',
      content: AccountStatementPage(
        accountEntity: accountEntity,
      ),
    );
  }
}
