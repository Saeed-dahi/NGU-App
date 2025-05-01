import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/features/upload/domain/entities/file_upload_entity.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_account_auto_complete.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_elevated_button.dart';
import 'package:ngu_app/core/widgets/custom_file_picker/custom_file_picker.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/cheques/presentation/blocs/cheque_bloc/cheque_bloc.dart';
import 'package:ngu_app/features/cheques/presentation/blocs/cheque_form_cubit/cubit/cheque_form_cubit.dart';
import 'package:ngu_app/features/cheques/presentation/widgets/cheque_toolbar.dart';

class CreateCheque extends StatefulWidget {
  const CreateCheque({super.key});

  @override
  State<CreateCheque> createState() => _CreateChequeState();
}

class _CreateChequeState extends State<CreateCheque> {
  final _basicChequeFormKey = GlobalKey<FormState>();
  final _moreInfoChequeFormKey = GlobalKey<FormState>();

  late bool _enableEditing;

  late ChequeFormCubit _chequeFormCubit;

  @override
  void initState() {
    _enableEditing = true;

    _chequeFormCubit = ChequeFormCubit();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChequeBloc, ChequeState>(
      builder: (context, state) {
        if (state is LoadingChequeState) {
          return Loaders.loading();
        }
        if (state is ValidationChequeState) {
          _chequeFormCubit.errors = state.errors;
          return _pageBody(context);
        }
        if (state is ErrorChequeState) {
          return MessageScreen(
            text: state.message,
          );
        }
        return _pageBody(context);
      },
    );
  }

  DefaultTabController _pageBody(
    BuildContext context,
  ) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Text(
            'cheque_card'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: Dimensions.primaryTextSize),
          ),
          ChequeToolbar(enableEditing: _enableEditing),
          const SizedBox(
            height: 10,
          ),
          TabBar(
            labelColor: Colors.black,
            indicatorColor: AppColors.primaryColor,
            tabs: [
              Tab(text: 'cheque'.tr),
              Tab(text: 'cheque_info'.tr),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: TabBarView(
              children: [
                // General Account info
                _chequeBasicInfoForm(context),
                _chequeMoreInfoForm(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chequeBasicInfoForm(
    BuildContext context,
  ) {
    return Form(
      key: _basicChequeFormKey,
      child: ListView(
        children: [
          Table(
            children: [
              TableRow(
                children: [
                  CustomDatePicker(
                    dateInput: _chequeFormCubit.dateController,
                    labelText: 'date'.tr,
                    autofocus: true,
                    enabled: _enableEditing,
                  ),
                  CustomInputField(
                    inputType: TextInputType.name,
                    enabled: _enableEditing,
                    controller: _chequeFormCubit.amountController,
                    label: 'cheque_amount'.tr,
                  ),
                  CustomInputField(
                    enabled: _enableEditing,
                    label: 'cheque_number'.tr,
                    controller: _chequeFormCubit.numberController,
                    error: _chequeFormCubit.errors['cheque_number']?.join('\n'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  CustomAccountAutoComplete(
                    enabled: _enableEditing,
                    label: 'issued_from_account',
                    controller: _chequeFormCubit.issuedFromAccount,
                    initialValue:
                        _chequeFormCubit.issuedFromAccount.arName ?? '',
                    error: _chequeFormCubit.errors['issued_from_account_id']
                        ?.join('\n'),
                  ),
                  CustomAccountAutoComplete(
                    enabled: _enableEditing,
                    controller: _chequeFormCubit.issuedToAccount,
                    label: 'issued_to_account',
                    initialValue: _chequeFormCubit.issuedToAccount.arName ?? '',
                    error: _chequeFormCubit.errors['issued_to_account_id']
                        ?.join('\n'),
                  ),
                  CustomAccountAutoComplete(
                    enabled: _enableEditing,
                    controller: _chequeFormCubit.targetBankAccount,
                    label: 'target_bank_account',
                    initialValue:
                        _chequeFormCubit.targetBankAccount.arName ?? '',
                    error: _chequeFormCubit.errors['target_bank_account_id']
                        ?.join('\n'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  CustomInputField(
                    controller: _chequeFormCubit.descriptionController,
                    label: 'description'.tr,
                    required: false,
                    enabled: _enableEditing,
                    error: _chequeFormCubit.errors['description']?.join('\n'),
                  ),
                  CustomDatePicker(
                    dateInput: _chequeFormCubit.dueDateController,
                    labelText: 'due_date'.tr,
                    required: false,
                    enabled: _enableEditing,
                    error: _chequeFormCubit.errors['due_date']?.join('\n'),
                  ),
                  CustomDropdown(
                    dropdownValue: getEnumValues(ChequeNature.values),
                    value: _chequeFormCubit.chequeNature,
                    helper: 'cheque_nature'.tr,
                    enabled: _enableEditing,
                    error: _chequeFormCubit.errors['nature']?.join('\n'),
                    onChanged: (value) {
                      _chequeFormCubit.chequeNature = value;
                    },
                  ),
                ],
              ),
            ],
          ),
          Visibility(
            visible: _enableEditing,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  color: AppColors.primaryColorLow,
                  text: 'save',
                  onPressed: () {
                    _onSave(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _chequeMoreInfoForm(BuildContext context) {
    return Form(
      key: _moreInfoChequeFormKey,
      child: ListView(
        children: [
          Table(
            children: [
              TableRow(children: [
                CustomInputField(
                  controller: _chequeFormCubit.notesController,
                  label: 'notes'.tr,
                  required: false,
                  enabled: _enableEditing,
                ),
                CustomFilePicker(
                  enableEditing: _enableEditing,
                  controller: _chequeFormCubit.imageController,
                  error: _chequeFormCubit.errors['file']?.join('\n'),
                ),
              ])
            ],
          ),
          Visibility(
            visible: _enableEditing,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  color: AppColors.primaryColorLow,
                  text: 'save',
                  onPressed: () {
                    _onSave(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onSave(BuildContext context) {
    if (_basicChequeFormKey.currentState!.validate()) {
      context.read<ChequeBloc>().add(CreateChequeEvent(
          cheque:
              _chequeFormCubit.getCheque(status: ChequeStatus.received.name),
          fileUploadEntity: FileUploadEntity(
              files: _chequeFormCubit.imageController.files,
              filesToDelete: _chequeFormCubit.imageController.filesToDelete)));
    }
  }
}
