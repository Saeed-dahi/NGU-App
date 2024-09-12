import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngu_app/app/config/constant.dart';
import 'package:ngu_app/core/widgets/custom_expansion_tile.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/custom_section_body.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/custom_section_title.dart';
import 'package:ngu_app/core/widgets/list_tile/basic_list_tile.dart';
import 'package:ngu_app/core/widgets/list_tile/custom_list_tile.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: Column(
        children: [
          CustomSectionTitle(title: 'settings'.tr, icon: Icons.settings),
          CustomSectionBody(
            children: [
              CustomExpansionTile(
                title: 'general_settings'.tr,
                icon: Icons.settings_outlined,
                children: [
                  BasicListTile(
                      title: 'system_constant'.tr,
                      icon: Icons.padding_outlined),
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
            ],
          ),
        ],
      ),
    );
  }
}
