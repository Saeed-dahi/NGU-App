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
  late ClosingAccountEntity _closingAccountEntity;
  late TextEditingController _arNameController;
  late TextEditingController _enNameController;

  late Map<String, dynamic> _errors;

  @override
  void initState() {
    _enNameController = TextEditingController();

    _arNameController = TextEditingController();
    _errors = {};
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
          _closingAccountEntity = state.closingAccount;
          return _pageBody(
            closingAccount: state.closingAccount,
            context: context,
            enableEditing: state.enableEditing,
          );
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
          _errors = state.errors;
          return _pageBody(
            closingAccount: _getFormData(),
            context: context,
            enableEditing: true,
          );
        }
        return Center(
          child: Loaders.loading(),
        );
      },
    );
  }

  Column _pageBody({
    required ClosingAccountEntity closingAccount,
    required BuildContext context,
    required bool enableEditing,
  }) {
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
        Expanded(child: _closingAccountForm(closingAccount, enableEditing)),
      ],
    );
  }

  void _onSave(BuildContext context, int accountId) {
    if (_formKey.currentState!.validate()) {
      context.read<ClosingAccountsBloc>().add(
            UpdateClosingAccountEvent(closingAccountEntity: _getFormData()),
          );
    }
  }

  Form _closingAccountForm(
      ClosingAccountEntity closingAccount, bool enableEditing) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          CustomInputField(
            inputType: TextInputType.name,
            enabled: false,
            helper: 'code'.tr,
            controller: TextEditingController(
                text: _closingAccountEntity.id.toString()),
          ),
          CustomInputField(
            inputType: TextInputType.name,
            enabled: enableEditing,
            helper: 'ar_name'.tr,
            controller: _arNameController,
            error: _errors['ar_name']?.join('\n'),
          ),
          CustomInputField(
            inputType: TextInputType.name,
            enabled: enableEditing,
            helper: 'en_name'.tr,
            controller: _enNameController,
            error: _errors['en_name']?.join('\n'),
          ),
        ],
      ),
    );
  }

  void _updateTextEditingController(ClosingAccountEntity closingAccount) {
    _enNameController = TextEditingController(text: closingAccount.enName);
    _arNameController = TextEditingController(text: closingAccount.arName);
  }

  ClosingAccountEntity _getFormData() {
    return ClosingAccountEntity(
      id: _closingAccountEntity.id,
      arName: _arNameController.text,
      enName: _enNameController.text,
    );
  }
}
