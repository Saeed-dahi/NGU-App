import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';

class ProductUnitsPrices extends StatelessWidget {
  final bool enableEditing;
  const ProductUnitsPrices({super.key, this.enableEditing = false});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildPricesCard(),
        _buildPricesCard(),
      ],
    );
  }

  Widget _buildPricesCard() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(Dimensions.primaryPadding),
          child: const Text(
            'كرتونة',
            style: TextStyle(
                color: AppColors.primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        Table(
          children: [
            TableRow(
              children: [
                CustomInputField(
                  helper: 'end_price'.tr,
                  enabled: enableEditing,
                ),
                CustomInputField(
                  helper: 'export_price'.tr,
                  enabled: enableEditing,
                ),
              ],
            ),
            TableRow(
              children: [
                CustomInputField(
                  helper: 'import_price'.tr,
                  enabled: enableEditing,
                ),
                CustomInputField(
                  helper: 'whole_sale_price'.tr,
                  enabled: enableEditing,
                ),
              ],
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
