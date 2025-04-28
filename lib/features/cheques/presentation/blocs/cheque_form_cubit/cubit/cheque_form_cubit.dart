import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/widgets/custom_file_picker/file_picker_controller.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';

part 'cheque_form_state.dart';

class ChequeFormCubit extends Cubit<ChequeFormState> {
  // Form Fields
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  FilePickerController imageController = FilePickerController();
  String? chequeNature;

  Map<String, dynamic> errors = {};

  ChequeFormCubit() : super(ChequeFormInitial());

  disposeController() {
    dateController.dispose();
    amountController.dispose();
    numberController.dispose();
    descriptionController.dispose();
    dueDateController.dispose();
    notesController.dispose();
  }

  void initControllers(ChequeEntity cheque) {
    dateController = TextEditingController(text: cheque.date);
    amountController = TextEditingController(text: cheque.amount.toString());
    numberController =
        TextEditingController(text: cheque.chequeNumber.toString());
    descriptionController = TextEditingController(text: cheque.notes);
    dueDateController = TextEditingController(text: cheque.dueDate);
    notesController = TextEditingController(text: cheque.notes);

    imageController = FilePickerController(initialFiles: [cheque.image!]);

    chequeNature = cheque.nature;
  }
}
