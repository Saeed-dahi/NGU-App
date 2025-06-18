import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_editable_text.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_bloc/adjustment_note_bloc.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_form_cubit/adjustment_note_form_cubit.dart';

class CustomAdjustmentNoteFooter extends StatelessWidget {
  final AdjustmentNoteFormCubit adjustmentNoteFormCubit;
  final AdjustmentNoteBloc adjustmentNoteBloc;
  final bool enableEditing;

  const CustomAdjustmentNoteFooter(
      {super.key,
      required this.adjustmentNoteFormCubit,
      required this.adjustmentNoteBloc,
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
                controller:
                    adjustmentNoteFormCubit.discountPercentageController,
                helper: '%',
                enable: enableEditing,
                onChanged: (p0) {
                  adjustmentNoteFormCubit.onChangeDiscountValue(
                      true, adjustmentNoteBloc.getPlutoGridController);
                },
              ),
              CustomEditableText(
                controller: adjustmentNoteFormCubit.discountAmountController,
                helper: 'constant_value'.tr,
                enable: enableEditing,
                onChanged: (p0) {
                  adjustmentNoteFormCubit.onChangeDiscountValue(
                      false, adjustmentNoteBloc.getPlutoGridController);
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
                controller:
                    adjustmentNoteFormCubit.subTotalAfterDiscountController,
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
                controller: adjustmentNoteFormCubit.totalController,
                enable: enableEditing,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
