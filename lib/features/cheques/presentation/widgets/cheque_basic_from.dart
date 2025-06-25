import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_account_auto_complete.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/cheques/presentation/blocs/cheque_form_cubit/cubit/cheque_form_cubit.dart';
import 'package:ngu_app/features/cheques/presentation/blocs/multiple_cheques_cubit/multiple_cheques_cubit.dart';

class ChequeBasicForm extends StatelessWidget {
  final GlobalKey<FormState> basicChequeFormKey;
  final ChequeFormCubit chequeFormCubit;
  final MultipleChequesCubit? multipleChequesCubit;
  final bool enableEditing;
  final BuildContext context;

  const ChequeBasicForm(
      {super.key,
      required this.basicChequeFormKey,
      required this.chequeFormCubit,
      this.multipleChequesCubit,
      required this.enableEditing,
      required this.context});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: basicChequeFormKey,
      child: Table(
        children: [
          TableRow(
            children: [
              CustomDatePicker(
                dateInput: chequeFormCubit.dateController,
                labelText: 'date'.tr,
                required: false,
                enabled: enableEditing,
                autofocus: true,
              ),
              CustomInputField(
                inputType: TextInputType.name,
                enabled: enableEditing,
                controller: chequeFormCubit.amountController,
                label: 'cheque_amount'.tr,
                format: FilteringTextInputFormatter.digitsOnly,
                onChanged: (value) {
                  if (multipleChequesCubit != null) {
                    multipleChequesCubit!.chequeAmount =
                        double.tryParse(value) ?? 0;
                    multipleChequesCubit!.changeAnyField();
                  }
                },
              ),
              CustomInputField(
                enabled: enableEditing,
                label: 'cheque_number'.tr,
                controller: chequeFormCubit.numberController,
                error: chequeFormCubit.errors['cheque_number']?.join('\n'),
                format: FilteringTextInputFormatter.digitsOnly,
              ),
            ],
          ),
          TableRow(
            children: [
              CustomAccountAutoComplete(
                enabled: enableEditing,
                label: 'client_account'.tr,
                controller: chequeFormCubit.issuedFromAccount,
                initialValue: chequeFormCubit.issuedFromAccount.arName ?? '',
                error: chequeFormCubit.errors['issued_from_account_id']
                    ?.join('\n'),
              ),
              CustomAccountAutoComplete(
                enabled: enableEditing,
                controller: chequeFormCubit.issuedToAccount,
                label: 'post_dated_cheques_account'.tr,
                initialValue: chequeFormCubit.issuedToAccount.arName ?? '',
                error:
                    chequeFormCubit.errors['issued_to_account_id']?.join('\n'),
              ),
              CustomAccountAutoComplete(
                enabled: enableEditing,
                controller: chequeFormCubit.targetBankAccount,
                label: 'target_bank_account',
                initialValue: chequeFormCubit.targetBankAccount.arName ?? '',
                error: chequeFormCubit.errors['target_bank_account_id']
                    ?.join('\n'),
              ),
            ],
          ),
          TableRow(
            children: [
              CustomInputField(
                controller: chequeFormCubit.descriptionController,
                label: 'description'.tr,
                required: false,
                enabled: enableEditing,
              ),
              CustomDatePicker(
                dateInput: chequeFormCubit.dueDateController,
                labelText: 'due_date'.tr,
                required: false,
                enabled: enableEditing,
              ),
              CustomDropdown(
                dropdownValue: getEnumValues(ChequeNature.values),
                value: chequeFormCubit.chequeNature,
                helper: 'cheque_nature'.tr,
                enabled: enableEditing,
                onChanged: (value) {
                  chequeFormCubit.chequeNature = value;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
