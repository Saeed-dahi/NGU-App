import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';

import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/custom_account_statement_pluto_table.dart';

class AccountStatementPage extends StatefulWidget {
  final int accountId;
  const AccountStatementPage({super.key, required this.accountId});

  @override
  State<AccountStatementPage> createState() => _AccountStatementPageState();
}

class _AccountStatementPageState extends State<AccountStatementPage> {
  late final AccountsBloc _accountsBloc;

  @override
  void initState() {
    _accountsBloc = sl<AccountsBloc>()
      ..add(AccountStatementEvent(accountId: widget.accountId));
    super.initState();
  }

  @override
  void dispose() {
    _accountsBloc.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    _accountsBloc.add(AccountStatementEvent(accountId: widget.accountId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _accountsBloc,
      child: CustomRefreshIndicator(
        child: ListView(
          children: [
            BlocBuilder<AccountsBloc, AccountsState>(
              builder: (context, state) {
                if (state is AccountStatementState) {
                  return CustomAccountStatementPlutoTable(
                      accountStatement: state.statement);
                }
                if (state is ErrorAccountsState) {
                  return Center(
                    child: MessageScreen(text: state.message),
                  );
                }
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  child: Center(
                    child: Loaders.loading(),
                  ),
                );
              },
            ),
          ],
        ),
        onRefresh: () => _refresh(),
      ),
    );
  }
}
