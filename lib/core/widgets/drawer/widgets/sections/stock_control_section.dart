import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/config/constant.dart';
import 'package:ngu_app/core/widgets/custom_expansion_tile.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/custom_section_body.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/custom_section_title.dart';
import 'package:ngu_app/core/widgets/lists_tile/basic_list_tile.dart';

class StockControlSection extends StatelessWidget {
  const StockControlSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: Column(
        children: [
          CustomSectionTitle(title: 'stock_control'.tr, icon: Icons.store),
          CustomSectionBody(
            children: [
              CustomExpansionTile(
                title: 'products'.tr,
                icon: Icons.inventory_2_outlined,
                children: [
                  BasicListTile(
                      title: 'product_card'.tr, icon: Icons.padding_outlined),
                  BasicListTile(title: 'search'.tr, icon: Icons.search),
                  BasicListTile(
                      title: 'products_table'.tr,
                      icon: Icons.table_chart_outlined),
                ],
              ),
              //
              CustomExpansionTile(
                title: 'purchase_invoices'.tr,
                icon: Icons.attach_money_outlined,
                children: [
                  BasicListTile(
                      title: 'all_invoices'.tr,
                      icon: Icons.assignment_outlined),
                  BasicListTile(
                      title: 'invoices_table'.tr,
                      icon: Icons.table_chart_outlined),
                  BasicListTile(
                      title: 'ready_invoices_table'.tr,
                      icon: Icons.done_all_outlined),
                  BasicListTile(
                      title: 'tax_invoices_table'.tr,
                      icon: Icons.request_quote_outlined),
                ],
              ),
              //
              CustomExpansionTile(
                title: 'sales_invoices'.tr,
                icon: Icons.receipt,
                children: [
                  BasicListTile(
                      title: 'all_invoices'.tr,
                      icon: Icons.assignment_outlined),
                  BasicListTile(
                      title: 'invoices_table'.tr,
                      icon: Icons.table_chart_outlined),
                  BasicListTile(
                      title: 'ready_invoices_table'.tr,
                      icon: Icons.done_all_outlined),
                  BasicListTile(
                      title: 'tax_invoices_table'.tr,
                      icon: Icons.request_quote_outlined),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
