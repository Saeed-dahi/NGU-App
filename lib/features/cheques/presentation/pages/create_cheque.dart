import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_elevated_button.dart';
import 'package:ngu_app/core/widgets/custom_file_picker/custom_file_picker.dart';
import 'package:ngu_app/core/widgets/custom_file_picker/file_picker_controller.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
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

  late Map<String, dynamic> _errors;
  @override
  void initState() {
    _errors = {};
    _enableEditing = true;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _pageBody(context);
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
                    dateInput: TextEditingController(),
                    labelText: 'date'.tr,
                    required: false,
                    enabled: _enableEditing,
                  ),
                  CustomInputField(
                    inputType: TextInputType.name,
                    enabled: _enableEditing,
                    controller: TextEditingController(),
                    label: 'cheque_amount'.tr,
                  ),
                  CustomInputField(
                    enabled: _enableEditing,
                    label: 'cheque_number'.tr,
                    controller: TextEditingController(),
                    error: _errors['cheque_number']?.join('\n'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  CustomInputField(
                    inputType: TextInputType.name,
                    enabled: _enableEditing,
                    label: 'issued_from_account'.tr,
                    controller: TextEditingController(),
                    error: _errors['issued_from_account']?.join('\n'),
                  ),
                  CustomInputField(
                    inputType: TextInputType.name,
                    enabled: _enableEditing,
                    controller: TextEditingController(),
                    label: 'issued_to_account'.tr,
                    error: _errors['issued_to_account']?.join('\n'),
                  ),
                  CustomInputField(
                    inputType: TextInputType.name,
                    enabled: _enableEditing,
                    controller: TextEditingController(),
                    label: 'target_bank_account'.tr,
                    error: _errors['target_bank_account']?.join('\n'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  CustomDatePicker(
                    dateInput: TextEditingController(),
                    labelText: 'description'.tr,
                    required: false,
                    enabled: _enableEditing,
                  ),
                  CustomDatePicker(
                    dateInput: TextEditingController(),
                    labelText: 'due_date'.tr,
                    required: false,
                    enabled: _enableEditing,
                  ),
                  CustomDropdown(
                    dropdownValue: getEnumValues(ChequeNature.values),
                    label: 'cheque_nature'.tr,
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
                CustomDatePicker(
                  dateInput: TextEditingController(),
                  labelText: 'notes'.tr,
                  required: false,
                  enabled: _enableEditing,
                ),
                CustomFilePicker(
                  enableEditing: _enableEditing,
                  controller: FilePickerController(),
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

  void _updateTextEditingController(AccountEntity account) {}

  void _onSave(BuildContext context) {
    if (_basicChequeFormKey.currentState!.validate()) {}
  }

  Future<void> _refresh() async {}
}
