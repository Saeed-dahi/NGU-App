import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/journals/presentation/bloc/journal_bloc.dart';

class CustomJournalFields extends StatelessWidget {
  const CustomJournalFields({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController journalIdController,
    required TextEditingController journalDocumentNumberController,
    required TextEditingController journalCreatedAtController,
    required TextEditingController journalDescriptionController,
    required JournalBloc journalBloc,
  })  : _formKey = formKey,
        _journalIdController = journalIdController,
        _journalDocumentNumberController = journalDocumentNumberController,
        _journalCreatedAtController = journalCreatedAtController,
        _journalDescriptionController = journalDescriptionController,
        _journalBloc = journalBloc;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _journalIdController;
  final TextEditingController _journalDocumentNumberController;
  final TextEditingController _journalCreatedAtController;
  final TextEditingController _journalDescriptionController;
  final JournalBloc _journalBloc;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Wrap(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.2,
            child: CustomInputField(
              inputType: TextInputType.text,
              controller: _journalIdController,
              label: 'code'.tr,
              readOnly: true,
              enabled: false,
              onTap: () {},
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.2,
            child: CustomInputField(
              inputType: TextInputType.text,
              controller: _journalDocumentNumberController,
              label: 'document_number'.tr,
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.2,
            child: CustomDatePicker(
                dateInput: _journalCreatedAtController,
                labelText: 'created_at'.tr),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.2,
            child: CustomInputField(
              inputType: TextInputType.text,
              controller: _journalDescriptionController,
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
    _journalBloc.getStateManger.setCurrentCell(
        _journalBloc.getStateManger.rows.first.cells.values.first, 0);
    _journalBloc.getStateManger.setKeepFocus(true);
  }
}
