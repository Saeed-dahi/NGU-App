import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/app_config/constant.dart';

import 'package:ngu_app/core/widgets/custom_elevated_button.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';

class ProductRecord extends StatefulWidget {
  const ProductRecord({
    super.key,
  });

  @override
  State<ProductRecord> createState() => _ProductRecordState();
}

class _ProductRecordState extends State<ProductRecord> {
  final _formKey = GlobalKey<FormState>();

  // Form Fields
  late TextEditingController _arNameController,
      _enNameController,
      _codeController;
  String? _accountType, _accountNature, _accountCategory;
  late bool _enableEditing;
  int? _closingAccountId;

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
    return _pageBody(
      context,
    );
  }

  DefaultTabController _pageBody(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Text(
            'product_record'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: Dimensions.primaryTextSize),
          ),
          const SizedBox(
            height: 10,
          ),
          TabBar(
            labelColor: Colors.black,
            indicatorColor: AppColors.primaryColor,
            tabs: [
              Tab(text: 'product'.tr),
              Tab(text: 'product_info'.tr),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // General Account info
                CustomRefreshIndicator(
                  onRefresh: _refresh,
                  content: _productBasicInfoForm(context),
                ),
                SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Form _productBasicInfoForm(
    BuildContext context,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.4,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 4),
              children: [
                CustomInputField(
                  inputType: TextInputType.name,
                  enabled: _enableEditing,
                  helper: 'en_name'.tr,
                  error: _errors['en_name']?.join('\n'),
                ),
                CustomInputField(
                  inputType: TextInputType.name,
                  enabled: _enableEditing,
                  helper: 'ar_name'.tr,
                  error: _errors['ar_name']?.join('\n'),
                ),
                CustomInputField(
                  inputType: TextInputType.name,
                  enabled: _enableEditing,
                  helper: 'code'.tr,
                  error: _errors['code']?.join('\n'),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _enableEditing,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  color: AppColors.primaryColorLow,
                  text: 'save',
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _updateTextEditingController(AccountEntity account) {
    _enNameController = TextEditingController(text: account.enName);
    _arNameController = TextEditingController(text: account.arName);
    _codeController = TextEditingController(text: account.code);
  }

  void _onSave(BuildContext context, AccountEntity account) {}

  _getFormData() {}

  Future<void> _refresh() async {}
}
