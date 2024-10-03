import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/custom_account_pluto_table.dart';

class AccountsTable extends StatefulWidget {
  const AccountsTable({super.key});

  @override
  State<AccountsTable> createState() => _AccountsTableState();
}

class _AccountsTableState extends State<AccountsTable> {
  late final AccountsBloc _accountsBloc;
  late TextEditingController searchController;
  Timer? _debounce;

  @override
  void initState() {
    searchController = TextEditingController();
    _accountsBloc = sl<AccountsBloc>()..add(GetAllAccountsEvent());
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    searchController.dispose();
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    await _accountsBloc.close();
  }

  Future<void> _refresh() async {
    _accountsBloc.add(GetAllAccountsEvent());
  }

  void _onSearchQuery(BuildContext context, String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _accountsBloc.add(SearchInAccountsEvent(
        query: value,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _accountsBloc,
      child: CustomRefreshIndicator(
        onRefresh: _refresh,
        content: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  child: CustomInputField(
                    inputType: TextInputType.text,
                    label: 'search'.tr,
                    controller: searchController,
                    onTap: () {},
                    onChanged: (value) {
                      _onSearchQuery(context, value);
                    },
                  ),
                ),
              ],
            ),
            BlocBuilder<AccountsBloc, AccountsState>(
              builder: (context, state) {
                if (state is GetAllAccountsState) {
                  return CustomAccountPlutoTable(
                    accounts: _accountsBloc.accountTable,
                  );
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
      ),
    );
  }
}
