import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_editable_text.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_bloc/invoice_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_form_cubit/invoice_form_cubit.dart';

class CustomInvoiceFooter extends StatelessWidget {
  final InvoiceFormCubit invoiceFormCubit;
  final InvoiceBloc invoiceBloc;
  final bool enableEditing;

  const CustomInvoiceFooter(
      {super.key,
      required this.invoiceFormCubit,
      required this.invoiceBloc,
      this.enableEditing = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.primaryPadding),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(Dimensions.borderRadius),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: Dimensions.primaryPadding,
            children: [
              Text(
                'discount_amount'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              CustomEditableText(
                controller: invoiceFormCubit.discountPercentageController,
                helper: '%',
                enable: enableEditing,
                onChanged: (p0) {
                  invoiceFormCubit.onChangeDiscountValue(
                      true, invoiceBloc.getPlutoGridController);
                },
              ),
              CustomEditableText(
                controller: invoiceFormCubit.discountConstantValueController,
                helper: 'constant_value'.tr,
                enable: enableEditing,
                onChanged: (p0) {
                  invoiceFormCubit.onChangeDiscountValue(
                      false, invoiceBloc.getPlutoGridController);
                },
              )
            ],
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: Dimensions.primaryPadding,
            children: [
              Text(
                'sub_total'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              CustomEditableText(
                controller: invoiceFormCubit.subTotalAfterDiscountController,
                enable: enableEditing,
              ),
            ],
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: Dimensions.primaryPadding,
            children: [
              Text(
                'total'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              CustomEditableText(
                controller: invoiceFormCubit.totalController,
                enable: enableEditing,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
