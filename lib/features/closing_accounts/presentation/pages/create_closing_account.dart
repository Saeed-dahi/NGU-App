import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';

import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/core/widgets/custom_elevated_button.dart';

import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_entity.dart';
import 'package:ngu_app/features/closing_accounts/presentation/bloc/closing_accounts_bloc.dart';

class CreateClosingAccount extends StatefulWidget {
  const CreateClosingAccount({super.key});

  @override
  State<CreateClosingAccount> createState() => _CreateClosingAccountState();
}

class _CreateClosingAccountState extends State<CreateClosingAccount> {
  final _formKey = GlobalKey<FormState>();

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
    return BlocConsumer<ClosingAccountsBloc, ClosingAccountsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingClosingAccountsState) {
          return Center(
            child: Loaders.loading(),
          );
        }
        if (state is ValidationClosingAccountState) {
          _errors = state.errors;
        }
        if (state is ErrorClosingAccountsState) {
          return MessageScreen(text: state.message);
        }
        return _pageBody(
          context,
        );
      },
    );
  }

  Column _pageBody(BuildContext context) {
    return Column(
      children: [
        Text(
          'add_new_account'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: Dimensions.primaryTextSize),
        ),
        const SizedBox(
          height: 10,
        ),
        createClosingAccountForm(context),
      ],
    );
  }

  Form createClosingAccountForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
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
          // Custom Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                color: AppColors.primaryColorLow,
                text: 'save',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<ClosingAccountsBloc>(context).add(
                        CreateClosingAccountEvent(
                            closingAccountEntity: ClosingAccountEntity(
                                arName: _arNameController.text,
                                enName: _enNameController.text)));
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
