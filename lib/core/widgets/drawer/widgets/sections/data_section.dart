import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/config/constant.dart';
import 'package:ngu_app/core/widgets/custom_expansion_tile.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/custom_section_body.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/custom_section_title.dart';
import 'package:ngu_app/core/widgets/lists_tile/basic_list_tile.dart';
import 'package:ngu_app/core/widgets/lists_tile/custom_list_tile.dart';
import 'package:ngu_app/core/widgets/tables/custom_pluto_table.dart';

class DataSection extends StatelessWidget {
  const DataSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: Column(
        children: [
          CustomSectionTitle(title: 'data'.tr, icon: Icons.folder),
          CustomSectionBody(
            children: [
              CustomListTile(
                title: 'open'.tr,
                icon: Icons.folder,
                isTrailing: false,
                onTap: () {
                  ShowDialog.showCustomDialog(
                      context: context, content: CustomPlutoTable());
                },
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
            ],
          ),
        ],
      ),
    );
  }
}
