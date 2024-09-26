import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/accounts/presentation/bloc/accounts_bloc.dart';
import 'package:ngu_app/features/accounts/presentation/pages/create_account.dart';

class AccountsToolbar extends StatelessWidget {
  final String accountId;
  final bool enableEditing;
  final VoidCallback? onSave;
  const AccountsToolbar({
    super.key,
    required this.accountId,
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
                  create: (context) => sl<AccountsBloc>()
                    ..add(GetSuggestionCodeEvent(parentId: accountId)),
                  child: CreateAccount(
                    parentAccountId: accountId,
                  ),
                ),
                width: 0.4,
                height: 0.5);
          },
        ),
        CustomIconButton(
          icon: Icons.edit,
          tooltip: 'edit'.tr,
          onPressed: () {
            context
                .read<AccountsBloc>()
                .add(const ToggleEditingEvent(enableEditing: true));
          },
        ),
        CustomIconButton(
          icon: Icons.info_outline,
          tooltip: 'account_sts'.tr,
          onPressed: () {},
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

  void _navigate(BuildContext context, String accountId, String direction) {
    return context.read<AccountsBloc>().add(
          ShowAccountsEvent(
            accountId: accountId,
            direction: direction,
          ),
        );
  }

  void _close(BuildContext context) {
    context
        .read<AccountsBloc>()
        .add(const ToggleEditingEvent(enableEditing: false));
  }
}
