import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_expansion_tile.dart';

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
              ]),
        ],
      ),
    );
  }
}
