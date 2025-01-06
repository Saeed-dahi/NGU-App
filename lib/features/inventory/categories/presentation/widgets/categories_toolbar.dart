import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/inventory/categories/presentation/bloc/category_bloc.dart';
import 'package:ngu_app/features/inventory/categories/presentation/pages/category_form.dart';

import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CategoriesToolbar extends StatelessWidget {
  final VoidCallback? onSave;

  const CategoriesToolbar({
    super.key,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: _crudActions(context),
    );
  }

  Widget _crudActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIconButton(
          icon: Icons.add,
          tooltip: 'add'.tr,
          onPressed: () => _onOpenForm(context, false),
        ),
        CustomIconButton(
          icon: Icons.edit,
          tooltip: 'edit'.tr,
          onPressed: () => _onOpenForm(context, true),
        ),
        CustomIconButton(
          icon: Icons.print,
          tooltip: 'print'.tr,
          onPressed: () {},
        ),
      ],
    );
  }

  _onOpenForm(BuildContext context, bool editingMode) {
    if (editingMode) {
      var currentRow = context
          .read<CategoryBloc>()
          .plutoGridController
          .stateManager!
          .currentRow;
      if (currentRow != null) {
        _showCategoryForm(
            context: context, editingMode: editingMode, currentRow: currentRow);
      }
    } else {
      _showCategoryForm(context: context, editingMode: editingMode);
    }
  }

  void _showCategoryForm(
      {required BuildContext context,
      required bool editingMode,
      PlutoRow? currentRow}) {
    ShowDialog.showCustomDialog(
        content: BlocProvider.value(
          value: context.read<CategoryBloc>(),
          child: CategoryForm(
            currentRow: currentRow,
          ),
        ),
        context: context,
        width: 0.4,
        height: 0.4);
  }
}
