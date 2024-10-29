import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/presentation/blocs/accounts_bloc.dart';
import 'package:ngu_app/features/accounts/presentation/pages/account_statement.dart';
import 'package:ngu_app/features/accounts/presentation/pages/create_account.dart';
import 'package:ngu_app/features/home/presentation/cubit/tab_cubit.dart';

class AccountsToolbar extends StatelessWidget {
  final AccountEntity accountEntity;
  final int accountId;
  final bool enableEditing;
  final VoidCallback? onSave;
  const AccountsToolbar({
    super.key,
    required this.accountId,
    required this.enableEditing,
    required this.accountEntity,
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
          onPressed: () {
            context
                .read<AccountsBloc>()
                .add(const ToggleEditingEvent(enableEditing: true));
          },
        ),
        CustomIconButton(
          icon: Icons.article_outlined,
          tooltip: 'account_sts'.tr,
          onPressed: () {
            Get.back();
            context.read<TabCubit>().addNewTab(
                  title:
                      '${'account_sts'.tr} (${accountEntity.enName}-${accountEntity.arName})',
                  content: AccountStatementPage(
                    accountEntity: accountEntity,
                  ),
                );
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

  void _add(BuildContext context) {
    ShowDialog.showCustomDialog(
        context: context,
        content: CreateAccount(
          parentAccountId: accountId,
        ),
        width: 0.4,
        height: 0.5);
  }
}
