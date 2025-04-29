import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_account_auto_complete.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_elevated_button.dart';
import 'package:ngu_app/core/widgets/custom_file_picker/custom_file_picker.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';
import 'package:ngu_app/features/cheques/presentation/blocs/cheque_bloc/cheque_bloc.dart';
import 'package:ngu_app/features/cheques/presentation/blocs/cheque_form_cubit/cubit/cheque_form_cubit.dart';
import 'package:ngu_app/features/cheques/presentation/widgets/cheque_toolbar.dart';

class ChequeRecord extends StatefulWidget {
  const ChequeRecord({super.key});

  @override
  State<ChequeRecord> createState() => _ChequeRecordState();
}

class _ChequeRecordState extends State<ChequeRecord> {
  final _basicChequeFormKey = GlobalKey<FormState>();
  final _moreInfoChequeFormKey = GlobalKey<FormState>();

  late final ChequeBloc _chequeBloc;
  late ChequeFormCubit _chequeFormCubit;

  late bool _enableEditing;

  @override
  void initState() {
    _enableEditing = false;
    _chequeBloc = sl<ChequeBloc>()..add(const ShowChequeEvent(id: 1));
    _chequeFormCubit = ChequeFormCubit();
    super.initState();
  }

  _initControllers(ChequeEntity cheque) {
    _chequeFormCubit = ChequeFormCubit()..initControllers(cheque);
  }

  @override
  void dispose() {
    _chequeBloc.close();
    _chequeFormCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _chequeBloc,
        ),
        BlocProvider(
          create: (context) => _chequeFormCubit,
        ),
      ],
      child: BlocBuilder<ChequeBloc, ChequeState>(
        builder: (context, state) {
          if (state is LoadedChequeState) {
            _initControllers(state.cheque);
            _enableEditing = state.enableEditing;
            _chequeFormCubit.errors = {};
            return _pageBody(context);
          }

          if (state is ValidationChequeState) {
            _initControllers(_chequeBloc.chequeEntity);
            _chequeFormCubit.errors = state.errors;
            return _pageBody(context);
          }

          if (state is ErrorChequeState) {
            return MessageScreen(
              text: state.message,
            );
          }
          return Loaders.loading();
        },
      ),
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
          ChequeToolbar(
            enableEditing: _enableEditing,
            chequeEntity: _chequeBloc.chequeEntity,
          ),
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
          Text(
            _chequeBloc.chequeEntity.status!.tr,
            style: const TextStyle(
              color: AppColors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                // General Account info
                CustomRefreshIndicator(
                  onRefresh: _refresh,
                  child: _chequeBasicInfoForm(context),
                ),
                CustomRefreshIndicator(
                  onRefresh: _refresh,
                  child: _chequeMoreInfoForm(context),
                ),
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
                    required: false,
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
                  ),
                  CustomDatePicker(
                    dateInput: _chequeFormCubit.dueDateController,
                    labelText: 'due_date'.tr,
                    required: false,
                    enabled: _enableEditing,
                  ),
                  CustomDropdown(
                    dropdownValue: getEnumValues(ChequeNature.values),
                    value: _chequeFormCubit.chequeNature,
                    helper: 'cheque_nature'.tr,
                    enabled: _enableEditing,
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
      _chequeBloc.add(UpdateChequeEvent(
          cheque: _chequeFormCubit.getCheque(
              id: _chequeBloc.chequeEntity.id,
              status: ChequeStatus.received.name)));
    }
  }

  Future<void> _refresh() async {
    _chequeBloc.add(ShowChequeEvent(id: _chequeBloc.chequeEntity.id!));
  }
}
