import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_elevated_button.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/inventory/categories/domain/entities/category_entity.dart';
import 'package:ngu_app/features/inventory/categories/presentation/bloc/category_bloc.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CategoryForm extends StatefulWidget {
  final PlutoRow? currentRow;
  const CategoryForm({super.key, this.currentRow});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _arNameController,
      _enNameController,
      _descriptionController;
  late Map<String, dynamic> _errors;

  @override
  void initState() {
    _arNameController = TextEditingController();
    _enNameController = TextEditingController();
    _descriptionController = TextEditingController();

    initFormDataInEditingMode();

    _errors = {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is LoadingCategoriesState) {
          return Loaders.loading();
        }
        if (state is ValidationCategoryState) {
          _errors = state.errors;
        }
        if (state is ErrorCategoriesState) {
          return MessageScreen(text: state.message);
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
          'category'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: Dimensions.primaryTextSize),
        ),
        const SizedBox(
          height: 10,
        ),
        createCategoryForm(context),
      ],
    );
  }

  Form createCategoryForm(BuildContext context) {
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
          CustomInputField(
            inputType: TextInputType.name,
            label: 'description'.tr,
            controller: _descriptionController,
            error: _errors['description']?.join('\n'),
            required: false,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                color: AppColors.primaryColorLow,
                text: 'save',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _onSave();
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

  initFormDataInEditingMode() {
    if (widget.currentRow != null) {
      _arNameController.text = widget.currentRow!.cells['ar_name']!.value;
      _enNameController.text = widget.currentRow!.cells['en_name']!.value;
      _descriptionController.text =
          widget.currentRow!.cells['description']!.value;
    }
  }

  void _onSave() {
    if (widget.currentRow != null) {
      context.read<CategoryBloc>().add(
            UpdateCategoryEvent(
              categoryEntity: CategoryEntity(
                  id: widget.currentRow!.data,
                  arName: _arNameController.text,
                  enName: _enNameController.text,
                  description: _descriptionController.text),
            ),
          );
    } else {
      context.read<CategoryBloc>().add(
            CreateCategoryEvent(
              categoryEntity: CategoryEntity(
                  arName: _arNameController.text,
                  enName: _enNameController.text,
                  description: _descriptionController.text),
            ),
          );
    }
  }
}
