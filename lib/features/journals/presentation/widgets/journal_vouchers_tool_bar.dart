import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ngu_app/core/widgets/custom_icon_button.dart';

class JournalVouchersToolBar extends StatelessWidget {
  const JournalVouchersToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Visibility(
        visible: true,
        replacement: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconButton(
                icon: Icons.close, tooltip: 'close'.tr, onPressed: () {}),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          onPressed: () {},
        ),
        CustomIconButton(
            icon: Icons.edit, tooltip: 'edit'.tr, onPressed: () {}),
        CustomIconButton(
            icon: Icons.save, tooltip: 'save'.tr, onPressed: () {}),
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
            onPressed: () {}),
        CustomIconButton(
            icon: Icons.arrow_left_rounded,
            tooltip: 'previous'.tr,
            onPressed: () {}),
        CustomIconButton(
            icon: Icons.arrow_right_rounded,
            tooltip: 'next'.tr,
            onPressed: () {}),
        CustomIconButton(
            icon: Icons.fast_forward_rounded,
            tooltip: 'last'.tr,
            onPressed: () {}),
      ],
    );
  }
}
