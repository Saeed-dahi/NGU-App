import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/core/widgets/custom_expansion_tile.dart';

class StockControlSection extends StatelessWidget {
  const StockControlSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'stock_control'.tr,
              style: const TextStyle(color: AppColors.secondaryColorLow),
            ),
            leading: const Icon(
              Icons.store,
              color: AppColors.secondaryColorLow,
            ),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.primaryPadding,
                right: Dimensions.primaryPadding),
            child: Column(
              children: [
                CustomExpansionTile(
                  title: 'products'.tr,
                  icon: Icons.inventory_2_outlined,
                  children: [
                    ListTile(
                      title: Text(
                        'product_card'.tr,
                      ),
                      leading: const Icon(
                        Icons.padding_outlined,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        'search'.tr,
                      ),
                      leading: const Icon(
                        Icons.search,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        'products_table'.tr,
                      ),
                      leading: const Icon(
                        Icons.table_chart_outlined,
                      ),
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
