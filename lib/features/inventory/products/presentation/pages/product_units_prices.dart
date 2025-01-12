import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_unit_entity.dart';
import 'package:ngu_app/features/inventory/products/presentation/bloc/product_bloc.dart';

class ProductUnitsPrices extends StatelessWidget {
  final bool enableEditing;
  final ProductBloc productBloc;
  const ProductUnitsPrices(
      {super.key, this.enableEditing = false, required this.productBloc});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productBloc.product.units!.length,
      itemBuilder: (context, index) {
        return _buildPricesCard(productBloc.product.units![index]);
      },
    );
  }

  Widget _buildPricesCard(ProductUnitEntity unit) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(Dimensions.primaryPadding),
          child: Text(
            unit.arName!,
            style: const TextStyle(
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
                  controller:
                      TextEditingController(text: unit.endPrice.toString()),
                ),
                CustomInputField(
                  helper: 'export_price'.tr,
                  enabled: enableEditing,
                  controller:
                      TextEditingController(text: unit.exportPrice.toString()),
                ),
              ],
            ),
            TableRow(
              children: [
                CustomInputField(
                  helper: 'import_price'.tr,
                  enabled: enableEditing,
                  controller:
                      TextEditingController(text: unit.importPrice.toString()),
                ),
                CustomInputField(
                  helper: 'whole_sale_price'.tr,
                  enabled: enableEditing,
                  controller: TextEditingController(
                      text: unit.wholeSalePrice.toString()),
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
