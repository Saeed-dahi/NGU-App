import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_entity.dart';
import 'package:ngu_app/features/inventory/products/presentation/pages/product_record.dart';

class ProductOptionMenu extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductOptionMenu({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'options'.tr,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('edit'.tr),
              const Icon(Icons.edit_outlined),
            ],
          ),
          onTap: () => _editProduct(context),
        ),
        PopupMenuItem<String>(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('product_sts'.tr),
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.info_outline_rounded),
            ],
          ),
          onTap: () => _productStatement(context),
        ),
      ],
    );
  }

  _editProduct(BuildContext context) async {
    ShowDialog.showCustomDialog(
        context: context,
        content: ProductRecord(
          productId: productEntity.id!,
        ),
        height: 0.6);
  }

  _productStatement(context) {}
}
