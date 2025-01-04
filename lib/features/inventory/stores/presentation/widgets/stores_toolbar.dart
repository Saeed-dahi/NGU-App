import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/features/inventory/stores/presentation/bloc/store_bloc.dart';

class StoresToolbar extends StatelessWidget {
  final bool enableEditing;
  final VoidCallback? onSave;
  const StoresToolbar({
    super.key,
    required this.enableEditing,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Visibility(
        visible: !enableEditing,
        replacement: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconButton(
              icon: Icons.close,
              tooltip: 'close'.tr,
              onPressed: () => _close(context),
            ),
            CustomIconButton(
              icon: Icons.save,
              tooltip: 'save'.tr,
              onPressed: () {
                context.read<StoreBloc>().add(GetStoresEvent());
                onSave;
              },
            ),
          ],
        ),
        child: _crudActions(context),
      ),
    );
  }

  Widget _crudActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIconButton(
          icon: Icons.edit,
          tooltip: 'edit'.tr,
          onPressed: () => _enableEditing(context),
        ),
        CustomIconButton(
          icon: Icons.print,
          tooltip: 'print'.tr,
          onPressed: () {},
        ),
      ],
    );
  }

  void _close(BuildContext context) {
    context
        .read<StoreBloc>()
        .add(const ToggleEditingEvent(enableEditing: false));
  }

  void _enableEditing(BuildContext context) {
    context
        .read<StoreBloc>()
        .add(const ToggleEditingEvent(enableEditing: true));
  }
}
