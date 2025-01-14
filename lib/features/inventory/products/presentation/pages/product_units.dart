import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';
import 'package:ngu_app/core/widgets/custom_container.dart';
import 'package:ngu_app/core/widgets/custom_editable_text.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_unit_entity.dart';
import 'package:ngu_app/features/inventory/products/presentation/bloc/product_bloc.dart';
import 'package:ngu_app/features/inventory/units/presentation/pages/units_table.dart';

class ProductUnit extends StatelessWidget {
  final bool enableEditing;
  final ProductBloc productBloc;
  Timer? _debounce;
  ProductUnit(
      {super.key, this.enableEditing = false, required this.productBloc});

  Future<int> _openUnitsDialog(BuildContext context) async {
    final result = await ShowDialog.showCustomDialog(
        context: context,
        content: UnitsTable(
          productId: productBloc.product.id,
        ),
        height: 0.6);
    return result != null ? result['unit_id'] : -1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: productBloc.product.units!.length,
          itemBuilder: (context, index) {
            return _buildUnitCard(context, productBloc.product.units![index],
                productBloc.product.units![index].subUnit);
          },
        )),
        CustomIconButton(
          icon: Icons.add,
          tooltip: 'add_new_unit'.tr,
          onPressed: () async {
            int unitId = await _openUnitsDialog(context);
            if (unitId != -1) {
              productBloc.add(CreateProductUnitEvent(
                  productUnitEntity:
                      getProductUnitEntity(productBloc.product.id!, unitId)));
            }
          },
        ),
      ],
    );
  }

  ProductUnitEntity getProductUnitEntity(int productId, int unitId) {
    return ProductUnitEntity(productId: productId, unitId: unitId);
  }

  Widget _buildUnitCard(BuildContext context, ProductUnitEntity unit,
      ProductUnitEntity? subUnit) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              unit.name!,
              style: const TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          if (subUnit != null) _buildWithSubUnit(unit, subUnit),
          if (subUnit == null) _buildWithoutSubUnit(context, unit),
        ],
      ),
    );
  }

  Padding _buildWithSubUnit(
      ProductUnitEntity unit, ProductUnitEntity? subUnit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            'each'.tr,
            style: const TextStyle(
                color: AppColors.primaryColorLow, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 8),
          Text(
            unit.name!,
            style: const TextStyle(
                color: AppColors.primaryColorLow, fontWeight: FontWeight.w700),
          ),
          CustomEditableText(
            controller:
                TextEditingController(text: unit.conversionFactor.toString()),
            enable: enableEditing,
            width: 0.04,
            onChanged: (value) {
              _onChange(unit, value);
            },
          ),
          Text(
            subUnit!.name!,
            style: const TextStyle(
                color: AppColors.primaryColorLow, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  void _onChange(ProductUnitEntity unit, String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 400),
      () {
        productBloc.add(
          UpdateProductUnitEvent(
            productUnitEntity: ProductUnitEntity(
              id: unit.id,
              conversionFactor: FormatterClass.doubleFormatter(value),
            ),
          ),
        );
      },
    );
  }

  Row _buildWithoutSubUnit(BuildContext context, ProductUnitEntity unit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('no_sub_unit'.tr),
        ),
        CustomIconButton(
          icon: Icons.add,
          tooltip: 'add_sub_unit'.tr,
          onPressed: () async {
            int unitId = await _openUnitsDialog(context);
            if (unitId != -1) {
              productBloc.add(CreateProductUnitEvent(
                  productUnitEntity:
                      getProductUnitEntity(productBloc.product.id!, unitId),
                  baseUnitId: unit.id));
            }
          },
        ),
      ],
    );
  }
}
