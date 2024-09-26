import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/utils/enums.dart';

import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/closing_accounts/presentation/bloc/closing_accounts_bloc.dart';
import 'package:ngu_app/features/closing_accounts/presentation/pages/create_closing_account.dart';

class ClosingAccountsToolbar extends StatelessWidget {
  final int accountId;
  final bool enableEditing;
  final VoidCallback? onSave;

  const ClosingAccountsToolbar({
    super.key,
    required this.accountId,
    this.enableEditing = false,
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
                icon: Icons.save, tooltip: 'save'.tr, onPressed: onSave),
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
          onPressed: () {
            ShowDialog.showCustomDialog(
              context: context,
              content: BlocProvider(
                create: (context) => sl<ClosingAccountsBloc>(),
                child: const CreateClosingAccount(),
              ),
              height: 0.3,
              width: 0.4,
            );
          },
        ),
        CustomIconButton(
          icon: Icons.edit,
          tooltip: 'edit'.tr,
          onPressed: () {
            context
                .read<ClosingAccountsBloc>()
                .add(const ToggleEditingEvent(enableEditing: true));
          },
        ),
        CustomIconButton(
          icon: Icons.print,
          tooltip: 'print'.tr,
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
            onPressed: () =>
                _navigate(context, accountId, DirectionType.first.name)),
        CustomIconButton(
            icon: Icons.arrow_left_rounded,
            tooltip: 'previous'.tr,
            onPressed: () =>
                _navigate(context, accountId, DirectionType.previous.name)),
        CustomIconButton(
            icon: Icons.arrow_right_rounded,
            tooltip: 'next'.tr,
            onPressed: () =>
                _navigate(context, accountId, DirectionType.next.name)),
        CustomIconButton(
            icon: Icons.fast_forward_rounded,
            tooltip: 'last'.tr,
            onPressed: () =>
                _navigate(context, accountId, DirectionType.last.name)),
      ],
    );
  }

  void _navigate(BuildContext context, int accountId, String direction) {
    return context.read<ClosingAccountsBloc>().add(
          ShowClosingsAccountsEvent(
            accountId: accountId,
            direction: direction,
          ),
        );
  }

  void _close(BuildContext context) {
    context
        .read<ClosingAccountsBloc>()
        .add(const ToggleEditingEvent(enableEditing: false));
  }
}
