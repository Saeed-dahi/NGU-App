import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_expansion_tile.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/lists_tile/basic_list_tile.dart';
import 'package:ngu_app/core/widgets/lists_tile/custom_list_tile.dart';
import 'package:ngu_app/features/inventory/stores/presentation/pages/stores_table.dart';

class StockControlSection extends StatelessWidget {
  final bool initiallyExpanded;
  const StockControlSection({super.key, this.initiallyExpanded = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: Column(
        children: [
          CustomExpansionTile(
              title: 'stock_control'.tr,
              icon: Icons.store,
              backgroundColor: const Color.fromARGB(90, 0, 0, 0),
              activeColor: AppColors.white,
              initiallyExpanded: initiallyExpanded,
              children: [
                CustomExpansionTile(
                  title: 'products'.tr,
                  icon: Icons.inventory_2_outlined,
                  children: [
                    BasicListTile(
                        title: 'product_record'.tr,
                        icon: Icons.padding_outlined,
                        onTap: () {}
                        // => ShowDialog.showCustomDialog(
                        //     context: context,
                        //     content: const ProductRecord(),
                        //     width: 0.5,
                        //     height: 0.6),
                        ),
                    BasicListTile(
                      title: 'search'.tr,
                      icon: Icons.search,
                      onTap: () {},
                    ),
                    BasicListTile(
                      title: 'products_table'.tr,
                      icon: Icons.search,
                      onTap: () {},
                    ),
                  ],
                ),
                CustomListTile(
                  title: 'stores'.tr,
                  onTap: () {
                    ShowDialog.showCustomDialog(
                        context: context, content: const StoresTable());
                  },
                  isTrailing: false,
                  icon: Icons.store_outlined,
                ),
                CustomListTile(
                  title: 'categories'.tr,
                  onTap: () {},
                  isTrailing: false,
                  icon: Icons.category_outlined,
                ),
                CustomListTile(
                  title: 'units'.tr,
                  onTap: () {},
                  isTrailing: false,
                  icon: Icons.pivot_table_chart_outlined,
                ),
              ]),
        ],
      ),
    );
  }
}
