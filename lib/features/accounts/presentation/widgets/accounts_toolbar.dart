import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/accounts/presentation/pages/add_new_account.dart';

class AccountsToolbar extends StatelessWidget {
  final bool editing = false;
  const AccountsToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Visibility(
        visible: !editing,
        replacement: CustomIconButton(
            icon: Icons.save, tooltip: 'save'.tr, onPressed: () {}),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: [
                CustomIconButton(
                  icon: Icons.fast_rewind_rounded,
                  tooltip: 'previous'.tr,
                  onPressed: () {},
                ),
                CustomIconButton(
                  icon: Icons.arrow_left_rounded,
                  tooltip: 'first'.tr,
                  onPressed: () {},
                ),
                CustomIconButton(
                  icon: Icons.arrow_right_rounded,
                  tooltip: 'next'.tr,
                  onPressed: () {},
                ),
                CustomIconButton(
                  icon: Icons.fast_forward_rounded,
                  tooltip: 'last'.tr,
                  onPressed: () {},
                ),
                CustomIconButton(
                  icon: Icons.search_outlined,
                  tooltip: 'search'.tr,
                  onPressed: () {},
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
                        content: const AddNewAccount(),
                        width: 0.4,
                        height: 0.5);
                  },
                ),
                CustomIconButton(
                  icon: Icons.edit,
                  tooltip: 'edit'.tr,
                  onPressed: () {},
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
            ),
          ],
        ),
      ),
    );
  }
}
