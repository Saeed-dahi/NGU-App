import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';
import 'package:ngu_app/features/accounts/presentation/pages/account_record.dart';
import 'package:ngu_app/features/accounts/presentation/pages/create_account.dart';
import 'package:ngu_app/features/closing_accounts/presentation/bloc/closing_accounts_bloc.dart';

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
        content: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<AccountsBloc>()
                ..add(ShowAccountsEvent(accountId: selectedId)),
            ),
            BlocProvider(
              create: (context) =>
                  sl<ClosingAccountsBloc>()..add(GetAllClosingAccountsEvent()),
            ),
          ],
          child: const AccountRecord(),
        ),
        height: 0.6);
  }

  _createAccount(BuildContext context) {
    ShowDialog.showCustomDialog(
        context: context,
        content: BlocProvider(
          create: (context) => sl<AccountsBloc>()
            ..add(GetSuggestionCodeEvent(parentId: selectedId)),
          child: CreateAccount(
            parentAccountId: selectedId,
          ),
        ),
        width: 0.4,
        height: 0.5);
  }
}
