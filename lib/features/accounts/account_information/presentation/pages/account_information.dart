import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/accounts/account_information/domain/entities/account_information_entity.dart';
import 'package:ngu_app/features/accounts/account_information/presentation/bloc/account_information_bloc.dart';
import 'package:ngu_app/features/accounts/presentation/widgets/accounts_toolbar.dart';

class AccountInformation extends StatefulWidget {
  final bool enableEditing;
  const AccountInformation({super.key, required this.enableEditing});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _mobileController;
  late TextEditingController _faxController;
  late TextEditingController _personToContactController;
  late TextEditingController _addressController;
  late TextEditingController _barcodeController;
  late TextEditingController _invoiceInformationController;

  late Map<String, dynamic> _errors;

  @override
  void initState() {
    _errors = {};
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _mobileController = TextEditingController();
    _faxController = TextEditingController();
    _personToContactController = TextEditingController();
    _addressController = TextEditingController();
    _barcodeController = TextEditingController();
    _invoiceInformationController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountInformationBloc, AccountInformationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadedAccountInformationState) {
          _errors = {};
          _updateTextEditingController(state.accountInformationEntity);
          return _pageBody(context, state.accountInformationEntity);
        }
        if (state is ErrorAccountInformationState) {
          return Column(
            children: [
              const AccountsToolbar(
                accountId: 1,
                enableEditing: false,
              ),
              MessageScreen(
                text: state.message,
              ),
            ],
          );
        }
        if (state is ValidationAccountInformationState) {
          _errors = state.errors;
          // with errors
          // return _pageBody(context, _getFormData());
        }
        return Center(
          child: Loaders.loading(),
        );
      },
    );
  }

  Form _pageBody(
      BuildContext context, AccountInformationEntity accountInformationEntity) {
    return Form(
      child: ListView(
        children: [
          Wrap(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  helper: 'phone'.tr,
                  controller: _phoneController,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  helper: 'email'.tr,
                  controller: _emailController,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  controller: _mobileController,
                  helper: 'mobile'.tr,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  controller: _faxController,
                  helper: 'fax'.tr,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  controller: _personToContactController,
                  helper: 'contact_person_name'.tr,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  controller: _addressController,
                  helper: 'address'.tr,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  controller: _barcodeController,
                  helper: 'barcode'.tr,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  controller: _invoiceInformationController,
                  helper: 'info_in_invoice'.tr,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: CustomInputField(
                  inputType: TextInputType.name,
                  enabled: widget.enableEditing,
                  controller: TextEditingController(text: '24323234'),
                  helper: 'file'.tr,
                ),
              ),
            ],
          ),
        ],
      ),
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
  }
}
