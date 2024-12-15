import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_auto_complete.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';
import 'package:ngu_app/features/accounts/presentation/pages/account_statement.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';

class AccountStatementDialog extends StatefulWidget {
  const AccountStatementDialog({super.key});

  @override
  State<AccountStatementDialog> createState() => _AccountStatementDialogState();
}

class _AccountStatementDialogState extends State<AccountStatementDialog> {
  late final AccountsBloc _accountsBloc;

  @override
  void initState() {
    _accountsBloc = sl<AccountsBloc>()..add(GetAccountsNameEvent());
    super.initState();
  }

  @override
  void dispose() {
    _accountsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _accountsBloc,
      child: BlocBuilder<AccountsBloc, AccountsState>(
        builder: (context, state) {
          if (state is GetAllAccountsState) {
            return CustomAutoComplete(
              data: _accountsBloc.accountsNameList,
              label: 'account',
              onSelected: (value) {
                var spitedValue = value.split('-');
                var desiredId = int.parse(_accountsBloc.accountsNameMap[
                    'id_${spitedValue[0].removeAllWhitespace}']);
                Get.back();
                context.read<TabCubit>().addNewTab(
                    content: AccountStatementPage(accountId: desiredId),
                    title:
                        '${'account_sts'.tr} (${spitedValue[1]} - ${spitedValue[2]})');
              },
            );
          }
          if (state is ErrorAccountsState) {
            return MessageScreen(text: state.message);
          }
          return Loaders.loading();
        },
      ),
    );
  }
}
