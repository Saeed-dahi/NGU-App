import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_elevated_button.dart';
import 'package:ngu_app/core/widgets/custom_file_picker/custom_file_picker.dart';
import 'package:ngu_app/core/widgets/custom_file_picker/file_picker_controller.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/inventory/categories/presentation/pages/categories_table.dart';
import 'package:ngu_app/features/inventory/products/presentation/bloc/product_bloc.dart';
import 'package:ngu_app/features/inventory/products/presentation/widgets/products_toolbar.dart';

class ProductRecord extends StatefulWidget {
  final int productId;
  const ProductRecord({super.key, this.productId = 1});

  @override
  State<ProductRecord> createState() => _ProductRecordState();
}

class _ProductRecordState extends State<ProductRecord> {
  final _formKey = GlobalKey<FormState>();
  late final ProductBloc _productBloc;

  // Form Fields
  late TextEditingController _arNameController,
      _enNameController,
      _codeController,
      _descriptionController,
      _barcodeController;
  String? _productType;
  late Map<String, dynamic> _categoryController;
  late FilePickerController _fileController;

  bool _enableEditing = false;

  late Map<String, dynamic> _errors;

  @override
  void initState() {
    _productBloc = sl<ProductBloc>()
      ..add(ShowProductEvent(id: widget.productId));
    _initControllers();
    _errors = {};

    super.initState();
  }

  @override
  void dispose() {
    _arNameController.dispose();
    _enNameController.dispose();
    _codeController.dispose();

    _productBloc.close();
    super.dispose();
  }

  void _initControllers() {
    _arNameController = TextEditingController();
    _enNameController = TextEditingController();
    _codeController = TextEditingController();
    _descriptionController = TextEditingController();
    _barcodeController = TextEditingController();
    _fileController = FilePickerController(initialFiles: []);
    _categoryController = {};
  }

  void _updateControllersValue() {
    _enNameController =
        TextEditingController(text: _productBloc.product.enName);
    _arNameController =
        TextEditingController(text: _productBloc.product.arName);
    _codeController = TextEditingController(text: _productBloc.product.code);
    _descriptionController =
        TextEditingController(text: _productBloc.product.description);
    _barcodeController =
        TextEditingController(text: _productBloc.product.barcode);
    _fileController =
        FilePickerController(initialFiles: _productBloc.product.files);
    _productType = _productBloc.product.type;
    if (_categoryController.isEmpty) {
      _categoryController = {
        'ar_name': _productBloc.product.category!.arName,
        'en_name': _productBloc.product.category!.enName,
      };
    }
  }

  void _onSave(BuildContext context, AccountEntity account) {}

  _getFormData() {}

  Future<void> _refresh() async {
    _productBloc.add(ShowProductEvent(id: _productBloc.product.id!));
  }

  _openCategoryDialog(BuildContext context) async {
    final result = await ShowDialog.showCustomDialog(
        context: context, content: const CategoriesTable());
    _productBloc.add(UpdateProductCategoryEvent(category: result ?? {}));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _productBloc,
      child: CustomRefreshIndicator(
        onRefresh: _refresh,
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is LoadedProductState) {
              _enableEditing = state.enableEditing;
              _categoryController = state.category;
              return _pageBody(
                context,
              );
            }
            if (state is ErrorProductsState) {
              return MessageScreen(text: state.message);
            }
            return Loaders.loading();
          },
        ),
      ),
    );
  }

  DefaultTabController _pageBody(BuildContext context) {
    _updateControllersValue();
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Text(
            'product_record'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: Dimensions.primaryTextSize),
          ),
          ProductsToolbar(
            enableEditing: _enableEditing,
            productBloc: _productBloc,
          ),
          const SizedBox(
            height: 10,
          ),
          TabBar(
            labelColor: Colors.black,
            indicatorColor: AppColors.primaryColor,
            tabs: [
              Tab(text: 'product'.tr),
              Tab(text: 'units'.tr),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // General Account info
                CustomRefreshIndicator(
                  onRefresh: _refresh,
                  child: _productBasicInfoForm(context),
                ),
                const SizedBox(),
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
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.4,
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 4),
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      CustomInputField(
                        enabled: _enableEditing,
                        helper: 'en_name'.tr,
                        controller: _enNameController,
                        error: _errors['en_name']?.join('\n'),
                      ),
                      CustomInputField(
                        enabled: _enableEditing,
                        helper: 'ar_name'.tr,
                        controller: _arNameController,
                        error: _errors['ar_name']?.join('\n'),
                      ),
                      CustomInputField(
                        enabled: _enableEditing,
                        helper: 'code'.tr,
                        controller: _codeController,
                        error: _errors['code']?.join('\n'),
                      ),
                      CustomInputField(
                        enabled: _enableEditing,
                        helper: 'description'.tr,
                        controller: _descriptionController,
                        error: _errors['description']?.join('\n'),
                      ),
                      CustomInputField(
                        enabled: _enableEditing,
                        helper: 'barcode'.tr,
                        controller: _barcodeController,
                        error: _errors['barcode']?.join('\n'),
                      ),
                      CustomDropdown(
                        dropdownValue: getEnumValues(ProductType.values),
                        enabled: _enableEditing,
                        helper: 'product_type'.tr,
                        value: _productBloc.product.type,
                        onChanged: (value) => _productType = value,
                      ),
                      CustomInputField(
                        enabled: _enableEditing,
                        helper: 'category'.tr,
                        error: _errors['category']?.join('\n'),
                        controller: TextEditingController(
                            text:
                                '${_categoryController['ar_name']} - ${_categoryController['en_name']}'),
                        onTap: () => _openCategoryDialog(context),
                        onEditingComplete: () => _openCategoryDialog(context),
                      ),
                    ],
                  ),
                ),
                CustomFilePicker(
                    controller: _fileController, enableEditing: _enableEditing),
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
}
