import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';
import 'package:ngu_app/features/accounts/presentation/pages/account_record.dart';

import 'package:ngu_app/features/accounts/presentation/pages/create_account.dart';
import 'package:ngu_app/features/closing_accounts/presentation/bloc/closing_accounts_bloc.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class OptionMenu extends StatelessWidget {
  final PlutoColumnRendererContext event;
  const OptionMenu({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: Text('add'.tr),
          onTap: () => _createAccount(context, event),
        ),
        PopupMenuItem<String>(
          child: Text('edit'.tr),
          onTap: () => _editAccount(context, event),
        ),
        PopupMenuItem<String>(
          child: Text('statement'.tr),
        ),
      ],
    );
  }

  _editAccount(BuildContext context, event) async {
    ShowDialog.showCustomDialog(
        context: context,
        content: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<AccountsBloc>()
                ..add(ShowAccountsEvent(accountId: event.row.data)),
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

  _createAccount(BuildContext context, event) {
    ShowDialog.showCustomDialog(
        context: context,
        content: BlocProvider(
          create: (context) => sl<AccountsBloc>()
            ..add(GetSuggestionCodeEvent(parentId: event.row.data)),
          child: CreateAccount(
            parentAccountId: event.row.data,
          ),
        ),
        width: 0.4,
        height: 0.5);
  }
}
