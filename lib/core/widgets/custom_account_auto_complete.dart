import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_auto_complete.dart';
import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';

class CustomAccountAutoComplete extends StatefulWidget {
  final bool enabled;
  final String initialValue;
  final String? error;

  dynamic accountController;

  CustomAccountAutoComplete(
      {super.key,
      required this.enabled,
      required this.initialValue,
      this.error,
      required this.accountController});

  @override
  State<CustomAccountAutoComplete> createState() =>
      _CustomAccountAutoCompleteState();
}

class _CustomAccountAutoCompleteState extends State<CustomAccountAutoComplete> {
  late final AccountsBloc _accountsBloc;

  @override
  void initState() {
    _accountsBloc = sl<AccountsBloc>()..add(GetAccountsNameEvent());
    super.initState();
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
              label: 'account'.tr,
              enabled: widget.enabled,
              initialValue: TextEditingValue(text: widget.initialValue),
              onSelected: (value) {
                // widget.accountController = widget.accountController.copyWith(
                //     arName: value, id: _accountsBloc.getDesiredId(value));

                widget.accountController.arName = value;
                widget.accountController.id = _accountsBloc.getDesiredId(value);
              },
              error: widget.error,
            );
          }
          return const LinearProgressIndicator();
        },
      ),
    );
  }
}
