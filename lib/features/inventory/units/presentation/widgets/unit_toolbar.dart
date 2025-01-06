import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/inventory/units/presentation/bloc/unit_bloc.dart';
import 'package:ngu_app/features/inventory/units/presentation/pages/unit_form.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class UnitToolbar extends StatelessWidget {
  final VoidCallback? onSave;

  const UnitToolbar({
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
      var currentRow =
          context.read<UnitBloc>().plutoGridController.stateManager!.currentRow;
      if (currentRow != null) {
        _showUnitForm(
            context: context, editingMode: editingMode, currentRow: currentRow);
      }
    } else {
      _showUnitForm(context: context, editingMode: editingMode);
    }
  }

  void _showUnitForm(
      {required BuildContext context,
      required bool editingMode,
      PlutoRow? currentRow}) {
    ShowDialog.showCustomDialog(
        content: BlocProvider.value(
          value: context.read<UnitBloc>(),
          child: UnitForm(
            currentRow: currentRow,
          ),
        ),
        context: context,
        width: 0.4,
        height: 0.4);
  }
}
