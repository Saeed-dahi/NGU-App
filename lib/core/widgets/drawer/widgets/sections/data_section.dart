import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_expansion_tile.dart';

import 'package:ngu_app/core/widgets/lists_tile/basic_list_tile.dart';
import 'package:ngu_app/core/widgets/lists_tile/custom_list_tile.dart';

class DataSection extends StatelessWidget {
  final bool initiallyExpanded;
  const DataSection({super.key, this.initiallyExpanded = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: Column(
        children: [
          CustomExpansionTile(
              backgroundColor: const Color.fromARGB(90, 0, 0, 0),
              activeColor: AppColors.white,
              title: 'data'.tr,
              icon: Icons.folder,
              initiallyExpanded: initiallyExpanded,
              children: [
                CustomListTile(
                  title: 'open'.tr,
                  icon: Icons.folder,
                  isTrailing: false,
                  onTap: () {},
                ),
                CustomListTile(
                  title: 'close'.tr,
                  icon: Icons.folder_off,
                  isTrailing: false,
                  onTap: () {},
                ),
                CustomExpansionTile(
                  title: 'backup'.tr,
                  icon: Icons.backup,
                  children: [
                    BasicListTile(
                        title: 'backup_all_data'.tr, icon: Icons.cloud_upload),
                    BasicListTile(
                        title: 'backup_some_data'.tr,
                        icon: Icons.cloud_upload_outlined),
                  ],
                )
              ]),
        ],
      ),
    );
  }
}
