import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_entity.dart';
import 'package:ngu_app/features/closing_accounts/presentation/bloc/closing_accounts_bloc.dart';
import 'package:ngu_app/features/closing_accounts/presentation/widgets/closing_accounts_toolbar.dart';

class ClosingAccountRecord extends StatefulWidget {
  const ClosingAccountRecord({super.key});

  @override
  State<ClosingAccountRecord> createState() => _ClosingAccountRecordState();
}

class _ClosingAccountRecordState extends State<ClosingAccountRecord> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _idController;

  late TextEditingController _arNameController;

  late TextEditingController _enNameController;

  @override
  void initState() {
    _enNameController = TextEditingController();
    _idController = TextEditingController();
    _arNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _arNameController.dispose();
    _enNameController.dispose();
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
              enableEditing: state.enableEditing,
              errors: {});
        }
        if (state is ErrorClosingAccountsState) {
          return Column(
            children: [
              const ClosingAccountsToolbar(
                accountId: -1,
              ),
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
              enableEditing: true,
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
      required bool enableEditing,
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
          enableEditing: enableEditing,
          onSave: () {
            _onSave(context, closingAccount.id!);
          },
        ),
        Expanded(
            child: _closingAccountForm(closingAccount, errors, enableEditing)),
      ],
    );
  }

  void _onSave(BuildContext context, int accountId) {
    if (_formKey.currentState!.validate()) {
      context.read<ClosingAccountsBloc>().add(
            UpdateClosingAccountEvent(
              closingAccountEntity: ClosingAccountEntity(
                // params
                id: accountId,
                //
                arName: _arNameController.text,
                enName: _enNameController.text,
              ),
            ),
          );
    }
  }

  Form _closingAccountForm(
      ClosingAccountEntity closingAccount, errors, bool enableEditing) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          CustomInputField(
            inputType: TextInputType.name,
            enabled: false,
            helper: 'code'.tr,
            controller: _idController,
          ),
          CustomInputField(
            inputType: TextInputType.name,
            enabled: enableEditing,
            helper: 'ar_name'.tr,
            controller: _arNameController,
            error: errors['ar_name']?.join('\n'),
          ),
          CustomInputField(
            inputType: TextInputType.name,
            enabled: enableEditing,
            helper: 'en_name'.tr,
            controller: _enNameController,
            error: errors['en_name']?.join('\n'),
          ),
        ],
      ),
    );
  }

  void _updateTextEditingController(ClosingAccountEntity closingAccount) {
    _idController = TextEditingController(text: closingAccount.id.toString());
    _enNameController = TextEditingController(text: closingAccount.enName);
    _arNameController = TextEditingController(text: closingAccount.arName);
  }

  ClosingAccountEntity _getPreviousFormData() {
    return ClosingAccountEntity(
      id: int.tryParse(_idController.text),
      arName: _arNameController.text,
      enName: _enNameController.text,
    );
  }
}
