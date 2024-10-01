import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/custom_account_pluto_table.dart';

class AccountsTable extends StatefulWidget {
  const AccountsTable({super.key});

  @override
  State<AccountsTable> createState() => _AccountsTableState();
}

class _AccountsTableState extends State<AccountsTable> {
  late TextEditingController searchController;
  Timer? _debounce;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
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
                  accounts: flattenAccounts(state.accounts),
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
    );
  }

  void _onSearchQuery(BuildContext context, String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<AccountsBloc>().add(SearchInAccountsEvent(
            query: value,
          ));
    });
  }

  Future<void> _refresh() async {
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
