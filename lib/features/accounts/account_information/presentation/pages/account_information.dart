import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_elevated_button.dart';
import 'package:ngu_app/core/widgets/custom_file_picker/custom_file_picker.dart';
import 'package:ngu_app/core/widgets/custom_file_picker/file_picker_controller.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/accounts/account_information/domain/entities/account_information_entity.dart';
import 'package:ngu_app/features/accounts/account_information/presentation/bloc/account_information_bloc.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';

class AccountInformation extends StatefulWidget {
  final bool enableEditing;
  final AccountEntity accountEntity;

  const AccountInformation(
      {super.key, required this.enableEditing, required this.accountEntity});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  late final AccountInformationBloc _accountInformationBloc;

  late TextEditingController _phoneController,
      _emailController,
      _mobileController,
      _faxController,
      _personToContactController,
      _addressController,
      _barcodeController,
      _descriptionController,
      _invoiceInformationController,
      _taxNumberController;

  late FilePickerController _fileController;

  late List<File>? files;

  late Map<String, dynamic> _errors;

  @override
  void initState() {
    _accountInformationBloc = sl<AccountInformationBloc>()
      ..add(ShowAccountInformationEvent(accountId: widget.accountEntity.id!));

    _errors = {};
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _mobileController = TextEditingController();
    _faxController = TextEditingController();
    _personToContactController = TextEditingController();
    _addressController = TextEditingController();
    _barcodeController = TextEditingController();
    _descriptionController = TextEditingController();
    _invoiceInformationController = TextEditingController();
    _taxNumberController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _accountInformationBloc.close();
    _phoneController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _faxController.dispose();
    _personToContactController.dispose();
    _addressController.dispose();
    _barcodeController.dispose();
    _descriptionController.dispose();
    _invoiceInformationController.dispose();
    _taxNumberController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    _accountInformationBloc
        .add(ShowAccountInformationEvent(accountId: widget.accountEntity.id!));
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: _refresh,
      child: BlocProvider(
        create: (context) => _accountInformationBloc,
        child: BlocConsumer<AccountInformationBloc, AccountInformationState>(
          listener: (context, state) {
            if (state is ValidationAccountInformationState) {
              context
                  .read<AccountsBloc>()
                  .add(const ToggleEditingEvent(enableEditing: true));
            } else {
              context
                  .read<AccountsBloc>()
                  .add(const ToggleEditingEvent(enableEditing: false));
            }
          },
          builder: (context, state) {
            if (state is LoadedAccountInformationState) {
              _errors = {};
              _updateTextEditingController(state.accountInformationEntity);
              return _pageBody(context, state.accountInformationEntity);
            }
            if (state is ErrorAccountInformationState) {
              return Center(
                child: MessageScreen(
                  text: state.message,
                ),
              );
            }
            if (state is ValidationAccountInformationState) {
              _errors = state.errors;
              return _pageBody(
                  context, _accountInformationBloc.accountInformationEntity);
            }
            return Center(
              child: Loaders.loading(),
            );
          },
        ),
      ),
    );
  }

  Form _pageBody(
      BuildContext context, AccountInformationEntity accountInformationEntity) {
    _fileController =
        FilePickerController(initialFiles: accountInformationEntity.files);
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  helper: 'phone'.tr,
                  controller: _phoneController,
                  error: _errors['phone']?.join('\n'),
                  autofocus: false,
                ),
                CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  helper: 'email'.tr,
                  controller: _emailController,
                  error: _errors['email']?.join('\n'),
                  autofocus: false,
                ),
                CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  controller: _mobileController,
                  helper: 'mobile'.tr,
                  error: _errors['mobile']?.join('\n'),
                  autofocus: false,
                ),
                CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  controller: _faxController,
                  helper: 'fax'.tr,
                  error: _errors['fax']?.join('\n'),
                  autofocus: false,
                ),
                CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  controller: _personToContactController,
                  helper: 'contact_person_name'.tr,
                  error: _errors['contact_person_name']?.join('\n'),
                  autofocus: false,
                ),
                CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  controller: _addressController,
                  helper: 'address'.tr,
                  error: _errors['address']?.join('\n'),
                  autofocus: false,
                ),
                CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  controller: _barcodeController,
                  helper: 'barcode'.tr,
                  error: _errors['barcode']?.join('\n'),
                  autofocus: false,
                ),
                CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  controller: _invoiceInformationController,
                  helper: 'info_in_invoice'.tr,
                  error: _errors['info_in_invoice']?.join('\n'),
                  autofocus: false,
                ),
                CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  controller: _taxNumberController,
                  helper: 'tax_number'.tr,
                  error: _errors['tax_number']?.join('\n'),
                  autofocus: false,
                ),
                CustomFilePicker(
                  enableEditing: widget.enableEditing,
                  controller: _fileController,
                  error: _errors['file']?.join('\n'),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.enableEditing,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  color: AppColors.primaryColorLow,
                  text: 'save',
                  onPressed: () {
                    _onSave();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _onSave() {
    _accountInformationBloc.add(
      UpdateAccountInformationEvent(
          accountInformationEntity: AccountInformationEntity(
            id: _accountInformationBloc.accountInformationEntity.id,
            phone: _phoneController.text,
            mobile: _mobileController.text,
            fax: _faxController.text,
            email: _emailController.text,
            contactPersonName: _personToContactController.text,
            address: _addressController.text,
            description: _descriptionController.text,
            infoInInvoice: _invoiceInformationController.text,
            taxNumber: _taxNumberController.text,
            barcode: _barcodeController.text,
          ),
          files: _fileController.files,
          filesToDelete: _fileController.filesToDelete),
    );
  }

  void _updateTextEditingController(AccountInformationEntity account) {
    _phoneController = TextEditingController(text: account.phone);
    _emailController = TextEditingController(text: account.email);
    _mobileController = TextEditingController(text: account.mobile);
    _faxController = TextEditingController(text: account.fax);
    _personToContactController =
        TextEditingController(text: account.contactPersonName);
    _addressController = TextEditingController(text: account.address);
    _barcodeController = TextEditingController(text: account.barcode);
    _invoiceInformationController =
        TextEditingController(text: account.infoInInvoice);
    _taxNumberController = TextEditingController(text: account.taxNumber);
  }
}
