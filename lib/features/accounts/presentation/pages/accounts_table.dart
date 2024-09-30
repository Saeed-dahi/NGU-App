import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';

import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/custom_account_pluto_table.dart';


class AccountsTable extends StatelessWidget {
  const AccountsTable({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        if (state is GetAllAccountsState) {
          return RefreshIndicator(
              onRefresh: () => _refresh(context),
              child: CustomAccountPlutoTable(
                accounts: flattenAccounts(state.accounts),
              ));
        }
        if (state is ErrorAccountsState) {
          return Center(
            child: MessageScreen(text: state.message),
          );
        }
        return Center(
          child: Loaders.loading(),
        );
      },
    );
  }

  Future<void> _refresh(BuildContext context) async {
    context.read<AccountsBloc>().add(GetAllAccountsEvent());
  }

  List<AccountEntity> flattenAccounts(List<AccountEntity> accounts) {
    List<AccountEntity> allAccounts = [];
    for (var account in accounts) {
      allAccounts.add(account); // Add the main account
      if (account.subAccounts.isNotEmpty) {
        allAccounts.addAll(flattenAccounts(
            account.subAccounts)); // Recursively add sub-accounts
      }
    }
    return allAccounts;
  }
}
