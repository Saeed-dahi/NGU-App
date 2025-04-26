import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_elevated_button.dart';
import 'package:ngu_app/core/widgets/custom_file_picker/custom_file_picker.dart';
import 'package:ngu_app/core/widgets/custom_file_picker/file_picker_controller.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';
import 'package:ngu_app/features/cheques/presentation/bloc/cheque_bloc.dart';
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

  late bool _enableEditing;

  late Map<String, dynamic> _errors;

  // Form Fields
  late TextEditingController _dateController,
      _amountController,
      _numberController,
      _descriptionController,
      _dueDateController,
      _notesController;
  late FilePickerController _imageController;
  String? _chequeNature;

  @override
  void initState() {
    _errors = {};
    _enableEditing = false;
    _chequeBloc = sl<ChequeBloc>()..add(const ShowChequeEvent(id: 1));

    _dateController = TextEditingController();
    _amountController = TextEditingController();
    _numberController = TextEditingController();
    _descriptionController = TextEditingController();
    _dueDateController = TextEditingController();
    _notesController = TextEditingController();

    _imageController = FilePickerController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _chequeBloc,
      child: BlocBuilder<ChequeBloc, ChequeState>(
        builder: (context, state) {
          if (state is LoadedChequeState) {
            _updateTextEditingController(state.cheque);
            _enableEditing = state.enableEditing;
            _errors = {};
            return _pageBody(context);
          }

          if (state is ValidationChequeState) {
            _errors = state.errors;
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

  Form _chequeBasicInfoForm(
    BuildContext context,
  ) {
    return Form(
      key: _basicChequeFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Table(
            children: [
              TableRow(
                children: [
                  CustomDatePicker(
                    dateInput: _dateController,
                    labelText: 'date'.tr,
                    required: false,
                    enabled: _enableEditing,
                  ),
                  CustomInputField(
                    inputType: TextInputType.name,
                    enabled: _enableEditing,
                    controller: _amountController,
                    helper: 'cheque_amount'.tr,
                  ),
                  CustomInputField(
                    enabled: _enableEditing,
                    helper: 'cheque_number'.tr,
                    controller: _numberController,
                    error: _errors['cheque_number']?.join('\n'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  CustomInputField(
                    inputType: TextInputType.name,
                    enabled: _enableEditing,
                    helper: 'issued_from_account'.tr,
                    controller: TextEditingController(),
                    error: _errors['issued_from_account']?.join('\n'),
                  ),
                  CustomInputField(
                    inputType: TextInputType.name,
                    enabled: _enableEditing,
                    controller: TextEditingController(),
                    helper: 'issued_to_account'.tr,
                    error: _errors['issued_to_account']?.join('\n'),
                  ),
                  CustomInputField(
                    inputType: TextInputType.name,
                    enabled: _enableEditing,
                    controller: TextEditingController(),
                    helper: 'target_bank_account'.tr,
                    error: _errors['target_bank_account']?.join('\n'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  CustomInputField(
                    controller: _descriptionController,
                    label: 'description'.tr,
                    required: false,
                    enabled: _enableEditing,
                  ),
                  CustomDatePicker(
                    dateInput: _dueDateController,
                    labelText: 'due_date'.tr,
                    required: false,
                    enabled: _enableEditing,
                  ),
                  CustomDropdown(
                    dropdownValue: getEnumValues(ChequeNature.values),
                    value: _chequeNature,
                    helper: 'cheque_nature'.tr,
                    enabled: _enableEditing,
                    onChanged: (value) {},
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

  Form _chequeMoreInfoForm(BuildContext context) {
    return Form(
      key: _moreInfoChequeFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Table(
            children: [
              TableRow(children: [
                CustomInputField(
                  controller: _notesController,
                  label: 'notes'.tr,
                  required: false,
                  enabled: _enableEditing,
                ),
                CustomFilePicker(
                  enableEditing: _enableEditing,
                  controller: _imageController,
                  error: _errors['file']?.join('\n'),
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

  void _updateTextEditingController(ChequeEntity cheque) {
    _dateController = TextEditingController(text: cheque.date);
    _amountController = TextEditingController(text: cheque.amount.toString());
    _numberController =
        TextEditingController(text: cheque.chequeNumber.toString());
    _descriptionController = TextEditingController(text: cheque.notes);
    _dueDateController = TextEditingController(text: cheque.dueDate);
    _notesController = TextEditingController(text: cheque.notes);

    _imageController = FilePickerController(initialFiles: [cheque.image!]);

    _chequeNature = cheque.nature;
  }

  void _onSave(BuildContext context) {
    if (_basicChequeFormKey.currentState!.validate()) {}
  }

  Future<void> _refresh() async {}
}
