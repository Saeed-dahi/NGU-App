import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/inventory/stores/presentation/bloc/store_bloc.dart';
import 'package:ngu_app/features/inventory/stores/presentation/pages/store_form.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class StoresToolbar extends StatelessWidget {
  final VoidCallback? onSave;

  const StoresToolbar({
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
          .read<StoreBloc>()
          .plutoGridController
          .stateManager!
          .currentRow;
      if (currentRow != null) {
        _showStoreForm(
            context: context, editingMode: editingMode, currentRow: currentRow);
      }
    } else {
      _showStoreForm(context: context, editingMode: editingMode);
    }
  }

  void _showStoreForm(
      {required BuildContext context,
      required bool editingMode,
      PlutoRow? currentRow}) {
    ShowDialog.showCustomDialog(
        content: BlocProvider.value(
          value: context.read<StoreBloc>(),
          child: StoreForm(
            currentRow: currentRow,
          ),
        ),
        context: context,
        width: 0.4,
        height: 0.4);
  }
}
