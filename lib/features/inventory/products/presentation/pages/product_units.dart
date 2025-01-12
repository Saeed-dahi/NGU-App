import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_container.dart';
import 'package:ngu_app/core/widgets/custom_editable_text.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/snack_bar.dart';
import 'package:ngu_app/features/inventory/units/presentation/pages/units_table.dart';

class ProductUnit extends StatelessWidget {
  final bool enableEditing;
  const ProductUnit({super.key, this.enableEditing = false});

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
            child: ListView(
          children: [
            _buildUnitCard(context, true),
            _buildUnitCard(context, false),
            _buildUnitCard(context, true),
          ],
        )),
        CustomIconButton(
          icon: Icons.add,
          tooltip: 'add_new_unit'.tr,
          onPressed: () => _openCategoryDialog(context),
        ),
      ],
    );
  }

  Widget _buildUnitCard(BuildContext context, subUnit) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'كرتونة',
              style: TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          Visibility(
            visible: subUnit,
            replacement: _buildWithSubUnit(context),
            child: _buildWithoutSubUnit('كرتونة', 'كيلو'),
          ),
        ],
      ),
    );
  }

  Padding _buildWithoutSubUnit(unit, subUnit) {
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
            unit,
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
            subUnit,
            style: const TextStyle(
                color: AppColors.primaryColorLow, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Row _buildWithSubUnit(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('لا يوجد وحدة مترابطة'),
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
