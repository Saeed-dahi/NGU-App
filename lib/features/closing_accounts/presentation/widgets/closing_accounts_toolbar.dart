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
  final bool editing;
  final VoidCallback? onSave;
  final GlobalKey formKey;
  const ClosingAccountsToolbar(
      {super.key,
      required this.accountId,
      this.editing = false,
      this.onSave,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Visibility(
        visible: !editing,
        replacement: CustomIconButton(
            icon: Icons.save, tooltip: 'save'.tr, onPressed: onSave),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: [
                CustomIconButton(
                  icon: Icons.fast_rewind_rounded,
                  tooltip: 'first'.tr,
                  onPressed: () {
                    _onPressed(context, accountId, DirectionType.first.name);
                  },
                ),
                CustomIconButton(
                  icon: Icons.arrow_left_rounded,
                  tooltip: 'previous'.tr,
                  onPressed: () {
                    _onPressed(context, accountId, DirectionType.previous.name);
                  },
                ),
                CustomIconButton(
                  icon: Icons.arrow_right_rounded,
                  tooltip: 'next'.tr,
                  onPressed: () {
                    _onPressed(context, accountId, DirectionType.next.name);
                  },
                ),
                CustomIconButton(
                  icon: Icons.fast_forward_rounded,
                  tooltip: 'last'.tr,
                  onPressed: () {
                    _onPressed(context, accountId, DirectionType.last.name);
                  },
                ),
              ],
            ),
            Wrap(
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
            ),
          ],
        ),
      ),
    );
  }

  void _onPressed(BuildContext context, int accountId, String direction) {
    return context.read<ClosingAccountsBloc>().add(
          ShowClosingsAccountsEvent(
            accountId: accountId,
            direction: direction,
          ),
        );
  }
}
