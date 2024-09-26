import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/presentation/bloc/accounts_bloc.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/accounts_toolbar.dart';

class AccountRecord extends StatefulWidget {
  const AccountRecord({super.key});

  @override
  State<AccountRecord> createState() => _AccountRecordState();
}

class _AccountRecordState extends State<AccountRecord> {
  final _formKey = GlobalKey<FormState>();

  late AccountEntity accountEntity;
  late TextEditingController _arNameController;
  late TextEditingController _enNameController;
  late TextEditingController _codeController;
  String? _accountType;
  String? _accountNature;
  String? _accountCategory;

  late bool _enableEditing;

  late Map<String, dynamic> _errors;
  @override
  void initState() {
    _arNameController = TextEditingController();
    _enNameController = TextEditingController();
    _codeController = TextEditingController();
    _errors = {};
    _enableEditing = false;
    super.initState();
  }

  @override
  void dispose() {
    _arNameController.dispose();
    _enNameController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        if (state is LoadedAccountsState) {
          _enableEditing = state.enableEditing;
          accountEntity = state.accountEntity;
          return _pageBody(context, state.accountEntity);
        }
        if (state is ErrorAccountsState) {
          return Column(
            children: [
              const AccountsToolbar(
                accountId: '',
                enableEditing: false,
              ),
              MessageScreen(
                text: state.message,
              ),
            ],
          );
        }
        if (state is ValidationAccountState) {
          _errors = state.errors;
          // with errors
          return _pageBody(context, _getPreviousFormData());
        }
        return Center(
          child: Loaders.loading(),
        );
      },
    );
  }

  DefaultTabController _pageBody(BuildContext context, AccountEntity account) {
    _updateTextEditingController(account);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Text(
            'account_record'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: Dimensions.primaryTextSize),
          ),
          const SizedBox(
            height: 10,
          ),
          AccountsToolbar(
            accountId: account.id!,
            enableEditing: _enableEditing,
            onSave: () {
              _onSave(context, account);
            },
          ),
          TabBar(
            labelColor: Colors.black,
            indicatorColor: AppColors.primaryColor,
            tabs: [
              Tab(text: 'account'.tr),
              Tab(text: 'account_info'.tr),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // General Account info
                _accountBasicInfoForm(context, account),
                const SizedBox(
                  child: Text('Account Information'),
                ),
                // all Account information
              ],
            ),
          ),
        ],
      ),
    );
  }

  Form _accountBasicInfoForm(BuildContext context, AccountEntity account) {
    return Form(
      key: _formKey,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 4),
        children: [
          CustomInputField(
            inputType: TextInputType.name,
            enabled: _enableEditing,
            helper: 'en_name'.tr,
            controller: _enNameController,
            error: _errors['en_name']?.join('\n'),
          ),
          CustomInputField(
            inputType: TextInputType.name,
            enabled: _enableEditing,
            helper: 'ar_name'.tr,
            controller: _arNameController,
            error: _errors['ar_name']?.join('\n'),
          ),
          CustomInputField(
            inputType: TextInputType.name,
            enabled: _enableEditing,
            controller: _codeController,
            helper: 'code'.tr,
            error: _errors['code']?.join('\n'),
          ),
          CustomInputField(
            inputType: TextInputType.name,
            enabled: _enableEditing,
            readOnly: true,
            controller: TextEditingController(text: account.balance.toString()),
            helper: 'balance'.tr,
          ),
          CustomDropdown(
            dropdownValue: getEnumValues(AccountType.values),
            helper: 'closing_account_id'.tr,
            value: account.accountType,
            enabled: _enableEditing,
            onChanged: (value) {
              // _accountType = value!;
            },
          ),
          CustomDropdown(
              dropdownValue: getEnumValues(AccountType.values),
              helper: 'account_type'.tr,
              value: account.accountType,
              enabled: _enableEditing,
              onChanged: (value) => _accountType = value),
          CustomDropdown(
              dropdownValue: getEnumValues(AccountNature.values),
              enabled: _enableEditing,
              helper: 'account_nature'.tr,
              value: account.accountNature,
              onChanged: (value) => _accountNature = value),
          CustomDropdown(
              dropdownValue: getEnumValues(AccountCategory.values),
              enabled: _enableEditing,
              value: account.accountCategory,
              helper: 'account_category'.tr,
              onChanged: (value) => _accountCategory = value

              // value: AccountCategory.asset.name,
              ),
        ],
      ),
    );
  }

  void _updateTextEditingController(AccountEntity account) {
    _enNameController = TextEditingController(text: account.enName);
    _arNameController = TextEditingController(text: account.arName);
    _codeController = TextEditingController(text: account.code);
  }

  void _onSave(BuildContext context, AccountEntity account) {
    if (_formKey.currentState!.validate()) {
      context.read<AccountsBloc>().add(
            UpdateAccountEvent(
                accountEntity: AccountEntity(
                    id: account.id,
                    code: _codeController.text,
                    arName: _arNameController.text,
                    enName: _enNameController.text,
                    parentId: account.parentId,
                    accountNature: _accountNature,
                    accountCategory: _accountCategory,
                    accountType: _accountType ?? account.accountType)),
          );
    }
  }

  AccountEntity _getPreviousFormData() {
    return AccountEntity(
      id: accountEntity.id,
      balance: accountEntity.balance,
      code: _codeController.text,
      arName: _arNameController.text,
      enName: _enNameController.text,
      accountType: _accountType ?? accountEntity.accountType,
      accountNature: _accountNature ?? accountEntity.accountNature,
      accountCategory: _accountCategory ?? accountEntity.accountCategory,
    );
  }
}
