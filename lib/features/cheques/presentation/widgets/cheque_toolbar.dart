import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';
import 'package:ngu_app/features/cheques/presentation/blocs/cheque_bloc/cheque_bloc.dart';
import 'package:ngu_app/features/cheques/presentation/pages/create_cheque.dart';

class ChequeToolbar extends StatelessWidget {
  final bool enableEditing;
  final VoidCallback? onSave;
  final ChequeEntity? chequeEntity;
  const ChequeToolbar(
      {super.key, required this.enableEditing, this.onSave, this.chequeEntity});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Visibility(
        visible: !enableEditing,
        replacement: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CustomIconButton(
            //     icon: Icons.save, tooltip: 'save'.tr, onPressed: onSave),
            CustomIconButton(
                icon: Icons.close,
                tooltip: 'close'.tr,
                onPressed: () => _close(context)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navigateActions(context),
            _crudActions(context),
          ],
        ),
      ),
    );
  }

  Wrap _crudActions(BuildContext context) {
    return Wrap(
      children: [
        CustomIconButton(
          icon: Icons.add,
          tooltip: 'add'.tr,
          onPressed: () => _add(context),
        ),
        CustomIconButton(
          icon: Icons.edit,
          tooltip: 'edit'.tr,
          onPressed: () => context
              .read<ChequeBloc>()
              .add(const ToggleEditingEvent(enableEditing: true)),
        ),
        CustomIconButton(
          icon: Icons.check,
          tooltip: 'deposit'.tr,
          onPressed: () {
            Get.back();
          },
        ),
        CustomIconButton(
          icon: Icons.print,
          tooltip: 'print'.tr,
          onPressed: () {},
        ),
        CustomIconButton(
          icon: Icons.delete_forever,
          tooltip: 'delete'.tr,
          onPressed: () {},
        ),
      ],
    );
  }

  Wrap _navigateActions(BuildContext context) {
    return Wrap(
      children: [
        CustomIconButton(
            icon: Icons.fast_rewind_rounded,
            tooltip: 'first'.tr,
            onPressed: () => _navigate(context, DirectionType.first.name)),
        CustomIconButton(
            icon: Icons.arrow_left_rounded,
            tooltip: 'previous'.tr,
            onPressed: () => _navigate(context, DirectionType.previous.name)),
        CustomIconButton(
            icon: Icons.arrow_right_rounded,
            tooltip: 'next'.tr,
            onPressed: () => _navigate(context, DirectionType.next.name)),
        CustomIconButton(
            icon: Icons.fast_forward_rounded,
            tooltip: 'last'.tr,
            onPressed: () => _navigate(context, DirectionType.last.name)),
      ],
    );
  }

  void _navigate(BuildContext context, String direction) {
    context
        .read<ChequeBloc>()
        .add(ShowChequeEvent(id: chequeEntity!.id!, direction: direction));
  }

  void _close(BuildContext context) {
    context
        .read<ChequeBloc>()
        .add(const ToggleEditingEvent(enableEditing: false));
  }

  void _add(BuildContext context) {
    ShowDialog.showCustomDialog(
        context: context,
        content: const CreateCheque(),
        height: 0.5,
        width: 0.7);
  }
}
