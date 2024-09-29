import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_elevated_button.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/presentation/bloc/accounts_bloc.dart';

class CreateAccount extends StatefulWidget {
  final int parentAccountId;
  const CreateAccount({super.key, required this.parentAccountId});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _arNameController;
  late TextEditingController _enNameController;
  late TextEditingController _codeController;
  late String? _accountType;

  late Map<String, dynamic> _errors;

  @override
  void initState() {
    _arNameController = TextEditingController();
    _enNameController = TextEditingController();
    _codeController = TextEditingController();
    _accountType = AccountType.main.name;
    _errors = {};
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
    return BlocConsumer<AccountsBloc, AccountsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingAccountsState) {
          return Center(
            child: Loaders.loading(),
          );
        }
        if (state is GetSuggestionCodeState) {
          _codeController.text = state.code;
        }
        if (state is ValidationAccountState) {
          _errors = state.errors;
        }
        if (state is ErrorAccountsState) {
          return MessageScreen(text: state.message);
        }
        return _pageBody(context);
      },
    );
  }

  Column _pageBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'add_new_account'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: Dimensions.primaryTextSize),
        ),
        const SizedBox(
          height: 10,
        ),
        createAccountForm(context),
      ],
    );
  }

  Form createAccountForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          CustomInputField(
            inputType: TextInputType.name,
            label: 'code'.tr,
            controller: _codeController,
            error: _errors['code']?.join('\n'),
          ),
          CustomInputField(
            inputType: TextInputType.name,
            label: 'ar_name'.tr,
            controller: _arNameController,
            error: _errors['ar_name']?.join('\n'),
          ),
          CustomInputField(
            inputType: TextInputType.name,
            label: 'en_name'.tr,
            controller: _enNameController,
            error: _errors['en_name']?.join('\n'),
          ),
          CustomDropdown(
            dropdownValue: getEnumValues(AccountType.values),
            label: 'account_type'.tr,
            value: 'main',
            onChanged: (value) {
              _accountType = value;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                color: AppColors.primaryColorLow,
                text: 'save',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AccountsBloc>().add(
                          CreateAccountEvent(
                            accountEntity: AccountEntity(
                              code: _codeController.text,
                              arName: _arNameController.text,
                              enName: _enNameController.text,
                              accountType: _accountType,
                              parentId: widget.parentAccountId,
                            ),
                          ),
                        );
                  }
                },
              ),
              CustomElevatedButton(
                color: AppColors.red,
                text: 'close',
                onPressed: () => Get.back(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
