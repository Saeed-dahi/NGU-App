import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_elevated_button.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_entity.dart';
import 'package:ngu_app/features/inventory/products/presentation/bloc/product_bloc.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  // Form Fields
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _arNameController,
      _enNameController,
      _codeController;

  late Map<String, dynamic> _errors;

  @override
  void initState() {
    _arNameController = TextEditingController();
    _enNameController = TextEditingController();
    _codeController = TextEditingController();

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
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is LoadingProductsState) {
          return Loaders.loading();
        }
        if (state is ErrorProductsState) {
          return MessageScreen(text: state.message);
        }
        if (state is ValidationProductState) {
          _errors = state.errors;
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
          'add_new_product'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: Dimensions.primaryTextSize),
        ),
        const SizedBox(
          height: 10,
        ),
        createProductForm(context),
      ],
    );
  }

  Form createProductForm(BuildContext context) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                color: AppColors.primaryColorLow,
                text: 'save',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<ProductBloc>().add(
                        CreateProductEvent(productEntity: _productEntity()));
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

  ProductEntity _productEntity() {
    return ProductEntity(
        arName: _arNameController.text,
        enName: _enNameController.text,
        code: _codeController.text);
  }
}
