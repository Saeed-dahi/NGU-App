import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_unit_entity.dart';
import 'package:ngu_app/features/inventory/products/presentation/bloc/product_bloc.dart';

class ProductUnitsPrices extends StatelessWidget {
  final bool enableEditing;
  final ProductBloc productBloc;
  Timer? _debounce;
  ProductUnitsPrices(
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

  ProductUnitEntity getProductUnitEntity(
      {required int id,
      double? endPrice,
      double? exportPrice,
      double? importPrice,
      double? wholeSalePrice}) {
    return ProductUnitEntity(
        id: id,
        endPrice: endPrice,
        exportPrice: exportPrice,
        importPrice: importPrice,
        wholeSalePrice: wholeSalePrice);
  }

  _onChange(
      {required int productUnitId,
      double? endPrice,
      double? exportPrice,
      double? importPrice,
      double? wholeSalePrice}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      productBloc.add(
        UpdateProductUnitEvent(
          productUnitEntity: getProductUnitEntity(
              id: productUnitId,
              endPrice: endPrice,
              exportPrice: exportPrice,
              importPrice: importPrice,
              wholeSalePrice: wholeSalePrice),
        ),
      );
    });
  }

  Widget _buildPricesCard(ProductUnitEntity unit) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(Dimensions.primaryPadding),
          child: Text(
            unit.name!,
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
                  onChanged: (value) => _onChange(
                    productUnitId: unit.id!,
                    endPrice: FormatterClass.doubleFormatter(value),
                  ),
                ),
                CustomInputField(
                  helper: 'export_price'.tr,
                  enabled: enableEditing,
                  controller: TextEditingController(
                    text: unit.exportPrice.toString(),
                  ),
                  onChanged: (value) => _onChange(
                    productUnitId: unit.id!,
                    exportPrice: FormatterClass.doubleFormatter(value),
                  ),
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
                  onChanged: (value) => _onChange(
                    productUnitId: unit.id!,
                    importPrice: FormatterClass.doubleFormatter(value),
                  ),
                ),
                CustomInputField(
                  helper: 'whole_sale_price'.tr,
                  enabled: enableEditing,
                  controller: TextEditingController(
                      text: unit.wholeSalePrice.toString()),
                  onChanged: (value) => _onChange(
                    productUnitId: unit.id!,
                    wholeSalePrice: FormatterClass.doubleFormatter(value),
                  ),
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
