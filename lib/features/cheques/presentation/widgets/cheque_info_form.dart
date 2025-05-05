import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_file_picker/custom_file_picker.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/cheques/presentation/blocs/cheque_form_cubit/cubit/cheque_form_cubit.dart';

class ChequeInfoFrom extends StatelessWidget {
  final GlobalKey<FormState> moreInfoChequeFormKey;
  final ChequeFormCubit chequeFormCubit;
  final bool enableEditing;
  final BuildContext context;

  const ChequeInfoFrom(
      {super.key,
      required this.moreInfoChequeFormKey,
      required this.chequeFormCubit,
      required this.enableEditing,
      required this.context});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: moreInfoChequeFormKey,
      child: ListView(
        children: [
          Table(
            children: [
              TableRow(children: [
                CustomInputField(
                  controller: chequeFormCubit.notesController,
                  label: 'notes'.tr,
                  required: false,
                  enabled: enableEditing,
                ),
                CustomFilePicker(
                  enableEditing: enableEditing,
                  controller: chequeFormCubit.imageController,
                  error: chequeFormCubit.errors['file']?.join('\n'),
                ),
              ])
            ],
          ),
        ],
      ),
    );
  }
}
