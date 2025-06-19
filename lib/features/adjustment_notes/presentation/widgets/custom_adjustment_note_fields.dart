import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/core/widgets/custom_account_auto_complete.dart';
import 'package:ngu_app/core/widgets/custom_container.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_bloc/adjustment_note_bloc.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_form_cubit/adjustment_note_form_cubit.dart';

class CustomAdjustmentNoteFields extends StatelessWidget {
  final bool enableEditing;
  final Map<String, dynamic> errors;
  final AdjustmentNoteFormCubit adjustmentNoteFormCubit;
  final AdjustmentNoteBloc adjustmentNoteBloc;

  const CustomAdjustmentNoteFields(
      {super.key,
      required this.enableEditing,
      required this.errors,
      required this.adjustmentNoteFormCubit,
      required this.adjustmentNoteBloc});

  @override
  Widget build(BuildContext context) {
    String? adjustmentNoteType =
        adjustmentNoteBloc.getAdjustmentNoteEntity.adjustmentNoteType;
    return BlocBuilder<AdjustmentNoteFormCubit, AdjustmentNoteFormState>(
      builder: (context, state) {
        return CustomContainer(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Table(
                  children: [
                    // General Info
                    TableRow(
                      children: [
                        CustomInputField(
                          label: 'adjustment_note_number'.tr,
                          enabled: enableEditing,
                          controller: adjustmentNoteFormCubit.numberController,
                          error: errors['adjustment_note_number']?.join('\n'),
                          format: FilteringTextInputFormatter.digitsOnly,
                          prefix: DateTime.now().year.toString(),
                        ),
                        CustomInputField(
                          label: 'document_number'.tr,
                          enabled: enableEditing,
                          controller:
                              adjustmentNoteFormCubit.documentNumberController,
                          error: errors['document_number']?.join('\n'),
                          required: false,
                        ),
                        CustomDatePicker(
                          dateInput: adjustmentNoteFormCubit.dateController,
                          labelText: 'created_at'.tr,
                          enabled: enableEditing,
                          error: errors['date']?.join('\n'),
                        ),
                      ],
                    ),
                    //  Primary Account
                    TableRow(
                      children: [
                        if (adjustmentNoteType == 'debit') const SizedBox(),
                        CustomInputField(
                          label: 'sub_total'.tr,
                          enabled: enableEditing,
                          controller:
                              adjustmentNoteFormCubit.subTotalController,
                          error: errors['sub_total']?.join('\n'),
                          required: false,
                          onChanged: (value) => adjustmentNoteFormCubit
                              .onUpdateSubController(value),
                        ),
                        CustomAccountAutoComplete(
                          enabled: enableEditing,
                          initialValue: adjustmentNoteFormCubit
                                  .primaryAccountController.arName ??
                              '',
                          error: errors['primary_account_id']?.join('\n'),
                          controller:
                              adjustmentNoteFormCubit.primaryAccountController,
                          label: '${'account'.tr} (${'debit'.tr})',
                        ),
                        if (adjustmentNoteType == 'credit') const SizedBox(),
                        // const SizedBox(),
                      ],
                    ),
                    // Tax Account
                    TableRow(
                      children: [
                        if (adjustmentNoteType == 'debit') const SizedBox(),
                        CustomInputField(
                          label: 'tax_amount'.tr,
                          enabled: false,
                          controller:
                              adjustmentNoteFormCubit.taxAmountController,
                          helper: '${Constant.taxRate}%',
                          format: FilteringTextInputFormatter.digitsOnly,
                          error: errors['tax_amount']?.join('\n'),
                        ),
                        CustomAccountAutoComplete(
                          enabled: enableEditing,
                          initialValue: adjustmentNoteFormCubit
                                  .taxAccountController.arName ??
                              '',
                          controller:
                              adjustmentNoteFormCubit.taxAccountController,
                          error: errors['tax_account_id']?.join('\n'),
                          label: 'tax_account',
                        ),
                        if (adjustmentNoteType == 'credit') const SizedBox(),
                      ],
                    ),
                    //  Secondary Account
                    TableRow(children: [
                      if (adjustmentNoteType == 'credit') const SizedBox(),
                      CustomInputField(
                        label: 'total'.tr,
                        enabled: enableEditing,
                        controller: adjustmentNoteFormCubit.totalController,
                        error: errors['total']?.join('\n'),
                        required: false,
                        onChanged: (value) => adjustmentNoteFormCubit
                            .onUpdateTotalController(value),
                      ),
                      CustomAccountAutoComplete(
                        enabled: enableEditing,
                        initialValue: adjustmentNoteFormCubit
                                .secondaryAccountController.arName ??
                            '',
                        controller:
                            adjustmentNoteFormCubit.secondaryAccountController,
                        error: errors['secondary_account_id']?.join('\n'),
                        label: '${'account'.tr} (${'credit'.tr})',
                      ),
                      if (adjustmentNoteType == 'debit') const SizedBox(),
                    ]),
                    // Description
                  ],
                ),
                CustomInputField(
                  label: 'description'.tr,
                  controller: adjustmentNoteFormCubit.descriptionController,
                  enabled: enableEditing,
                  error: errors['tax_account_description']?.join('\n'),
                  required: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
