import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_container.dart';
import 'package:ngu_app/core/widgets/custom_editable_text.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/snack_bar.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_unit_entity.dart';
import 'package:ngu_app/features/inventory/products/presentation/bloc/product_bloc.dart';
import 'package:ngu_app/features/inventory/units/presentation/pages/units_table.dart';

class ProductUnit extends StatelessWidget {
  final bool enableEditing;
  final ProductBloc productBloc;
  const ProductUnit(
      {super.key, this.enableEditing = false, required this.productBloc});

  _openCategoryDialog(BuildContext context) async {
    final result = await ShowDialog.showCustomDialog(
        context: context, content: const UnitsTable(), height: 0.6);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: productBloc.product.units!.length,
          itemBuilder: (context, index) {
            return _buildUnitCard(context, productBloc.product.units![index],
                productBloc.product.units![index].subUnit);
          },
        )),
        CustomIconButton(
          icon: Icons.add,
          tooltip: 'add_new_unit'.tr,
          onPressed: () => _openCategoryDialog(context),
        ),
      ],
    );
  }

  Widget _buildUnitCard(BuildContext context, ProductUnitEntity unit,
      ProductUnitEntity? subUnit) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              unit.arName!,
              style: const TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          if (subUnit != null) _buildWithSubUnit(unit, subUnit),
          if (subUnit == null) _buildWithoutSubUnit(context, unit),
        ],
      ),
    );
  }

  Padding _buildWithSubUnit(
      ProductUnitEntity unit, ProductUnitEntity? subUnit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            'each'.tr,
            style: const TextStyle(
                color: AppColors.primaryColorLow, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 8),
          Text(
            unit.arName!,
            style: const TextStyle(
                color: AppColors.primaryColorLow, fontWeight: FontWeight.w700),
          ),
          CustomEditableText(
            controller: TextEditingController(text: '10000'),
            enable: enableEditing,
            width: 0.04,
            onEditingComplete: () =>
                ShowSnackBar.showSuccessSnackbar(message: 'success'.tr),
          ),
          Text(
            subUnit!.arName!,
            style: const TextStyle(
                color: AppColors.primaryColorLow, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Row _buildWithoutSubUnit(BuildContext context, ProductUnitEntity unit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('no_sub_unit'.tr),
        ),
        CustomIconButton(
          icon: Icons.add,
          tooltip: 'add_sub_unit'.tr,
          onPressed: () => _openCategoryDialog(context),
        ),
      ],
    );
  }
}
