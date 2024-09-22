import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/config/constant.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_entity.dart';
import 'package:ngu_app/features/closing_accounts/presentation/bloc/closing_accounts_bloc.dart';
import 'package:ngu_app/features/closing_accounts/presentation/widgets/closing_accounts_toolbar.dart';

class ClosingAccounts extends StatelessWidget {
  final bool enableEditing = false;
  const ClosingAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClosingAccountsBloc, ClosingAccountsState>(
      builder: (context, state) {
        if (state is LoadedClosingAccountsState) {
          return _pageBody(closingAccount: state.closingAccounts);
        }
        if (state is ErrorClosingAccountsState) {
          return MessageScreen(
            text: state.message,
          );
        }
        return Center(
          child: Loaders.loading(),
        );
      },
    );
  }

  Column _pageBody({required ClosingAccountEntity closingAccount}) {
    return Column(
      children: [
        Text(
          'account_record'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: Dimensions.primaryTextSize),
        ),
        const SizedBox(
          height: 10,
        ),
        ClosingAccountsToolbar(
          accountId: closingAccount.id,
        ),
        CustomInputField(
          inputType: TextInputType.name,
          enabled: enableEditing,
          helper: 'code'.tr,
          controller: TextEditingController(text: closingAccount.id.toString()),
        ),
        CustomInputField(
          inputType: TextInputType.name,
          enabled: enableEditing,
          helper: 'en_name'.tr,
          controller: TextEditingController(text: closingAccount.enName),
        ),
        CustomInputField(
          inputType: TextInputType.name,
          enabled: enableEditing,
          helper: 'ar_name'.tr,
          controller: TextEditingController(text: closingAccount.arName),
        ),
      ],
    );
  }
}
