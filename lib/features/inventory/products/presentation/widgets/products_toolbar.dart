import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/dialogs/custom_dialog.dart';
import 'package:ngu_app/features/inventory/products/presentation/bloc/product_bloc.dart';
import 'package:ngu_app/features/inventory/products/presentation/pages/create_product.dart';

class ProductsToolbar extends StatelessWidget {
  final bool enableEditing;
  final VoidCallback? onSave;
  final ProductBloc productBloc;

  const ProductsToolbar({
    super.key,
    required this.enableEditing,
    required this.productBloc,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Visibility(
        visible: !enableEditing,
        replacement: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconButton(
                icon: Icons.close,
                tooltip: 'close'.tr,
                onPressed: () => _close(context)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navigateActions(context),
            _crudActions(context),
          ],
        ),
      ),
    );
  }

  Wrap _crudActions(BuildContext context) {
    return Wrap(
      children: [
        CustomIconButton(
          icon: Icons.add,
          tooltip: 'add'.tr,
          onPressed: () => _add(context),
        ),
        CustomIconButton(
          icon: Icons.edit,
          tooltip: 'edit'.tr,
          onPressed: () =>
              productBloc.add(const ToggleEditingEvent(enableEditing: true)),
        ),
        CustomIconButton(
          icon: Icons.article_outlined,
          tooltip: 'product_sts'.tr,
          onPressed: () {},
        ),
        CustomIconButton(
          icon: Icons.print,
          tooltip: 'print'.tr,
          onPressed: () {},
        ),
        CustomIconButton(
          icon: Icons.delete_forever,
          tooltip: 'delete'.tr,
          onPressed: () {},
        ),
      ],
    );
  }

  Wrap _navigateActions(BuildContext context) {
    return Wrap(
      children: [
        CustomIconButton(
            icon: Icons.fast_rewind_rounded,
            tooltip: 'first'.tr,
            onPressed: () => _navigate(DirectionType.first.name)),
        CustomIconButton(
            icon: Icons.arrow_left_rounded,
            tooltip: 'previous'.tr,
            onPressed: () => _navigate(DirectionType.previous.name)),
        CustomIconButton(
            icon: Icons.arrow_right_rounded,
            tooltip: 'next'.tr,
            onPressed: () => _navigate(DirectionType.next.name)),
        CustomIconButton(
            icon: Icons.fast_forward_rounded,
            tooltip: 'last'.tr,
            onPressed: () => _navigate(DirectionType.last.name)),
      ],
    );
  }

  void _navigate(String direction) {
    productBloc.add(
        ShowProductEvent(id: productBloc.product.id!, direction: direction));
  }

  void _close(BuildContext context) {
    productBloc.add(const ToggleEditingEvent(enableEditing: false));
  }

  void _add(BuildContext context) {
    ShowDialog.showCustomDialog(
        context: context,
        content: BlocProvider.value(
          value: productBloc,
          child: const CreateProduct(),
        ),
        width: 0.4,
        height: 0.4);
  }
}
