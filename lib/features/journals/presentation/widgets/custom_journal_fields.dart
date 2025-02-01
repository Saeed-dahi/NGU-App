import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/journals/presentation/bloc/journal_bloc.dart';

class CustomJournalFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController journalIdController;
  final TextEditingController journalDocumentNumberController;
  final TextEditingController journalCreatedAtController;
  final TextEditingController journalDescriptionController;
  final JournalBloc journalBloc;
  final bool enableEditing;

  const CustomJournalFields(
      {super.key,
      required this.formKey,
      required this.journalIdController,
      required this.journalDocumentNumberController,
      required this.journalCreatedAtController,
      required this.journalDescriptionController,
      required this.journalBloc,
      required this.enableEditing});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Wrap(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.2,
            child: CustomInputField(
              inputType: TextInputType.text,
              controller: journalIdController,
              label: 'code'.tr,
              readOnly: true,
              enabled: enableEditing,
              onTap: () {},
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.2,
            child: CustomInputField(
              inputType: TextInputType.text,
              controller: journalDocumentNumberController,
              label: 'document_number'.tr,
              enabled: enableEditing,
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.2,
            child: CustomDatePicker(
                dateInput: journalCreatedAtController,
                enabled: enableEditing,
                labelText: 'created_at'.tr),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.2,
            child: CustomInputField(
              inputType: TextInputType.text,
              controller: journalDescriptionController,
              enabled: enableEditing,
              label: 'description'.tr,
              onEditingComplete: () {
                _moveFocusToTable();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _moveFocusToTable() {
    journalBloc.getStateManger.setCurrentCell(
        journalBloc.getStateManger.rows.first.cells.values.first, 0);
    journalBloc.getStateManger.setKeepFocus(true);
  }
}
