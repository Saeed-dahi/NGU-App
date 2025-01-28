import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_expansion_tile.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/core/widgets/lists_tile/basic_list_tile.dart';
import 'package:ngu_app/core/widgets/lists_tile/custom_list_tile.dart';
import 'package:ngu_app/features/inventory/categories/presentation/pages/categories_table.dart';
import 'package:ngu_app/features/inventory/products/presentation/pages/product_record.dart';
import 'package:ngu_app/features/inventory/products/presentation/pages/products_table.dart';
import 'package:ngu_app/features/inventory/stores/presentation/pages/stores_table.dart';
import 'package:ngu_app/features/inventory/units/presentation/pages/units_table.dart';

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
                      onTap: () => ShowDialog.showCustomDialog(
                          context: context,
                          content: const ProductRecord(),
                          width: 0.5,
                          height: 0.6),
                    ),
                    BasicListTile(
                      title: 'products_table'.tr,
                      icon: Icons.table_chart_outlined,
                      onTap: () => ShowDialog.showCustomDialog(
                          context: context, content: const ProductsTable()),
                    ),
                  ],
                ),
                CustomExpansionTile(
                  title: 'sales_invoices'.tr,
                  icon: Icons.receipt_long,
                  children: [
                    BasicListTile(
                        title: 'invoice'.tr, icon: Icons.receipt, onTap: () {}),
                    BasicListTile(
                      title: 'all_invoices'.tr,
                      icon: Icons.view_list,
                      onTap: () {},
                    ),
                    BasicListTile(
                      title: 'invoices_table'.tr,
                      icon: Icons.table_chart,
                      onTap: () {},
                    ),
                    BasicListTile(
                      title: 'ready_invoices_table'.tr,
                      icon: Icons.done_all_outlined,
                      onTap: () {},
                    ),
                    BasicListTile(
                      title: 'tax_invoices_table'.tr,
                      icon: Icons.request_quote,
                      onTap: () {},
                    ),
                    const Divider(
                      color: AppColors.primaryColor,
                    ),
                    BasicListTile(
                      title: 'returns'.tr,
                      icon: Icons.autorenew,
                      onTap: () {},
                    ),
                    BasicListTile(
                      title: 'returns_table'.tr,
                      icon: Icons.table_chart,
                      onTap: () {},
                    ),
                    BasicListTile(
                      title: 'tax_returns_table'.tr,
                      icon: Icons.request_quote,
                      onTap: () {},
                    ),
                  ],
                ),
                CustomExpansionTile(
                  title: 'purchase_invoices'.tr,
                  icon: Icons.receipt_long,
                  children: [
                    BasicListTile(
                        title: 'invoice'.tr, icon: Icons.receipt, onTap: () {}),
                    BasicListTile(
                      title: 'all_invoices'.tr,
                      icon: Icons.view_list,
                      onTap: () {},
                    ),
                    BasicListTile(
                      title: 'invoices_table'.tr,
                      icon: Icons.table_chart,
                      onTap: () {},
                    ),
                    BasicListTile(
                      title: 'ready_invoices_table'.tr,
                      icon: Icons.done_all_outlined,
                      onTap: () {},
                    ),
                    BasicListTile(
                      title: 'tax_invoices_table'.tr,
                      icon: Icons.request_quote,
                      onTap: () {},
                    ),
                    const Divider(
                      color: AppColors.primaryColor,
                    ),
                    BasicListTile(
                      title: 'returns'.tr,
                      icon: Icons.autorenew,
                      onTap: () {},
                    ),
                    BasicListTile(
                      title: 'returns_table'.tr,
                      icon: Icons.table_chart,
                      onTap: () {},
                    ),
                    BasicListTile(
                      title: 'tax_returns_table'.tr,
                      icon: Icons.request_quote,
                      onTap: () {},
                    ),
                  ],
                ),
                CustomListTile(
                  title: 'stores'.tr,
                  onTap: () {
                    ShowDialog.showCustomDialog(
                        context: context,
                        content: const StoresTable(),
                        height: 0.6);
                  },
                  isTrailing: false,
                  icon: Icons.store_outlined,
                ),
                CustomListTile(
                  title: 'categories'.tr,
                  onTap: () {
                    ShowDialog.showCustomDialog(
                        context: context,
                        content: const CategoriesTable(),
                        height: 0.6);
                  },
                  isTrailing: false,
                  icon: Icons.category_outlined,
                ),
                CustomListTile(
                  title: 'units'.tr,
                  onTap: () {
                    ShowDialog.showCustomDialog(
                        context: context,
                        content: const UnitsTable(),
                        height: 0.6);
                  },
                  isTrailing: false,
                  icon: Icons.pivot_table_chart_outlined,
                ),
              ]),
        ],
      ),
    );
  }
}
