import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_account_auto_complete.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_bloc/adjustment_note_bloc.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_form_cubit/adjustment_note_form_cubit.dart';

class CustomAdjustmentNoteFields extends StatelessWidget {
  final bool enable;
  final Map<String, dynamic> errors;
  final AdjustmentNoteFormCubit adjustmentNoteFormCubit;
  final AdjustmentNoteBloc adjustmentNoteBloc;

  const CustomAdjustmentNoteFields(
      {super.key,
      required this.enable,
      required this.errors,
      required this.adjustmentNoteFormCubit,
      required this.adjustmentNoteBloc});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Table(
        children: [
          TableRow(
            children: [
              CustomInputField(
                label: 'invoice_number'.tr,
                enabled: enable,
                controller: adjustmentNoteFormCubit.numberController,
                error: errors['invoice_number']?.join('\n'),
                format: FilteringTextInputFormatter.digitsOnly,
                prefix: DateTime.now().year.toString(),
              ),
              CustomInputField(
                label: 'document_number'.tr,
                enabled: enable,
                controller: adjustmentNoteFormCubit.documentNumberController,
                error: errors['document_number']?.join('\n'),
                required: false,
              ),
              CustomDatePicker(
                dateInput: adjustmentNoteFormCubit.dateController,
                labelText: 'created_at'.tr,
                enabled: enable,
                error: errors['date']?.join('\n'),
              ),
              CustomAccountAutoComplete(
                enabled: enable,
                initialValue:
                    adjustmentNoteFormCubit.accountController.arName ?? '',
                controller: adjustmentNoteFormCubit.accountController,
                error: errors['account_id']?.join('\n'),
                label: 'account',
              ),
            ],
          ),
          TableRow(
            children: [
              CustomInputField(
                label: 'address'.tr,
                enabled: enable,
                controller: adjustmentNoteFormCubit.addressController,
                error: errors['address']?.join('\n'),
                required: false,
              ),
              CustomInputField(
                label: 'notes'.tr,
                enabled: enable,
                controller: adjustmentNoteFormCubit.notesController,
                error: errors['notes']?.join('\n'),
                required: false,
              ),
              CustomDatePicker(
                dateInput: adjustmentNoteFormCubit.dueDateController,
                labelText: 'due_date'.tr,
                enabled: enable,
                error: errors['due_date']?.join('\n'),
                required: false,
              ),
              const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
