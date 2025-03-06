import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_expansion_tile.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/lists_tile/basic_list_tile.dart';
import 'package:ngu_app/core/widgets/lists_tile/custom_list_tile.dart';
import 'package:ngu_app/features/settings/presentation/system_constant.dart';

class SettingsSection extends StatelessWidget {
  final bool initiallyExpanded;
  const SettingsSection({super.key, this.initiallyExpanded = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: Column(
        children: [
          CustomExpansionTile(
              title: 'settings'.tr,
              icon: Icons.settings,
              backgroundColor: const Color.fromARGB(90, 0, 0, 0),
              activeColor: AppColors.white,
              initiallyExpanded: initiallyExpanded,
              children: [
                CustomExpansionTile(
                  title: 'general_settings'.tr,
                  icon: Icons.settings_outlined,
                  children: [
                    BasicListTile(
                      title: 'system_constant'.tr,
                      icon: Icons.padding_outlined,
                      onTap: () => ShowDialog.showCustomDialog(
                          context: context, content: SystemConstant()),
                    ),
                    BasicListTile(
                        title: 'information_constant'.tr, icon: Icons.search),
                  ],
                ),
                CustomListTile(
                  title: 'export'.tr,
                  icon: Icons.import_export,
                  isTrailing: false,
                  onTap: () {},
                ),
                CustomListTile(
                  title: 'import'.tr,
                  icon: Icons.import_export,
                  isTrailing: false,
                  onTap: () {},
                ),
                CustomListTile(
                  title: 'shortcuts'.tr,
                  icon: Icons.keyboard,
                  isTrailing: false,
                  onTap: () {},
                ),
              ]),
        ],
      ),
    );
  }
}
