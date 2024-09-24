import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/config/constant.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_entity.dart';
import 'package:ngu_app/features/closing_accounts/presentation/bloc/closing_accounts_bloc.dart';
import 'package:ngu_app/features/closing_accounts/presentation/widgets/closing_accounts_toolbar.dart';

class ClosingAccounts extends StatefulWidget {
  const ClosingAccounts({super.key});

  @override
  State<ClosingAccounts> createState() => _ClosingAccountsState();
}

class _ClosingAccountsState extends State<ClosingAccounts> {
  final bool enableEditing = true;

  final formKey = GlobalKey<FormState>();

  late TextEditingController idController;

  late TextEditingController arNameController;

  late TextEditingController enNameController;

  @override
  void initState() {
    enNameController = TextEditingController();
    idController = TextEditingController();
    arNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    arNameController.dispose();
    enNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClosingAccountsBloc, ClosingAccountsState>(
      builder: (context, state) {
        if (state is LoadedClosingAccountsState) {
          return _pageBody(
              closingAccount: state.closingAccounts,
              context: context,
              errors: {});
        }
        if (state is ErrorClosingAccountsState) {
          return Column(
            children: [
              ClosingAccountsToolbar(accountId: -1, formKey: formKey),
              MessageScreen(
                text: state.message,
              ),
            ],
          );
        }
        if (state is ValidationClosingAccountState) {
          return _pageBody(
              closingAccount: _getPreviousFormData(),
              context: context,
              errors: state.errors);
        }
        return Center(
          child: Loaders.loading(),
        );
      },
    );
  }

  Column _pageBody(
      {required ClosingAccountEntity closingAccount,
      required BuildContext context,
      required Map<String, dynamic> errors}) {
    // init text Controllers
    _updateTextEditingController(closingAccount);
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
          accountId: closingAccount.id!,
          editing: enableEditing,
          formKey: formKey,
          onSave: () {
            _onSave(context, closingAccount.id!);
          },
        ),
        _closingAccountForm(closingAccount, errors),
      ],
    );
  }

  void _onSave(BuildContext context, int accountId) {
    if (formKey.currentState!.validate()) {
      context.read<ClosingAccountsBloc>().add(
            UpdateClosingAccountEvent(
              closingAccountEntity: ClosingAccountEntity(
                // params
                id: accountId,
                //
                arName: arNameController.text,
                enName: enNameController.text,
              ),
            ),
          );
    }
  }

  Form _closingAccountForm(ClosingAccountEntity closingAccount, errors) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomInputField(
            inputType: TextInputType.name,
            enabled: false,
            helper: 'code'.tr,
            controller: idController,
          ),
          CustomInputField(
            inputType: TextInputType.name,
            enabled: enableEditing,
            helper: 'en_name'.tr,
            controller: enNameController,
            error: errors['en_name']?.join('\n'),
          ),
          CustomInputField(
            inputType: TextInputType.name,
            enabled: enableEditing,
            helper: 'ar_name'.tr,
            controller: arNameController,
            error: errors['ar_name']?.join('\n'),
          ),
        ],
      ),
    );
  }

  void _updateTextEditingController(ClosingAccountEntity closingAccount) {
    idController = TextEditingController(text: closingAccount.id.toString());
    enNameController = TextEditingController(text: closingAccount.enName);
    arNameController = TextEditingController(text: closingAccount.arName);
  }

  ClosingAccountEntity _getPreviousFormData() {
    return ClosingAccountEntity(
      id: int.tryParse(idController.text),
      arName: arNameController.text,
      enName: enNameController.text,
    );
  }
}
