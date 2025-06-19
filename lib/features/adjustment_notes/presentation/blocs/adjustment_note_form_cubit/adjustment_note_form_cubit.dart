import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';

import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_account_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_entity.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_bloc/adjustment_note_bloc.dart';

part 'adjustment_note_form_state.dart';

class AdjustmentNoteFormCubit extends Cubit<AdjustmentNoteFormState> {
  final String adjustmentNoteType;

  TextEditingController numberController = TextEditingController();
  TextEditingController documentNumberController = TextEditingController();
  final TextEditingController adjustmentNoteSearchNumController =
      TextEditingController();

  late TextEditingController dateController = TextEditingController();
  late TextEditingController dueDateController = TextEditingController();

  late TextEditingController descriptionController = TextEditingController();

  late AdjustmentNoteAccountEntity primaryAccountController;
  late AdjustmentNoteAccountEntity secondaryAccountController;

  late AdjustmentNoteAccountEntity taxAccountController;
  late TextEditingController taxAmountController = TextEditingController();

  late TextEditingController totalController = TextEditingController();
  late TextEditingController subTotalController = TextEditingController();

  final AdjustmentNoteBloc adjustmentNoteBloc;
  AdjustmentNoteFormCubit(
      {required this.adjustmentNoteBloc, required this.adjustmentNoteType})
      : super(AdjustmentNoteFormInitial());

  initControllers(AdjustmentNoteEntity adjustmentNote) {
    numberController = TextEditingController(
        text: adjustmentNote.adjustmentNoteNumber.toString());
    documentNumberController =
        TextEditingController(text: adjustmentNote.documentNumber.toString());
    dateController = TextEditingController(text: adjustmentNote.date);
    dueDateController = TextEditingController(text: adjustmentNote.dueDate);

    primaryAccountController = adjustmentNote.primaryAccount!;

    descriptionController =
        TextEditingController(text: adjustmentNote.description);

    secondaryAccountController = adjustmentNote.secondaryAccount!;

    taxAccountController = adjustmentNote.taxAccount!;

    taxAmountController =
        TextEditingController(text: adjustmentNote.taxAmount.toString());

    totalController.text = adjustmentNote.total.toString();
    subTotalController.text = adjustmentNote.subTotal.toString();
  }

  disposeControllers() {
    dateController.dispose();
    dueDateController.dispose();
    numberController.dispose();
    documentNumberController.dispose();
    descriptionController.dispose();
    taxAmountController.dispose();
    totalController.dispose();
  }

  AdjustmentNoteEntity adjustmentNoteEntity(Enum status) {
    return AdjustmentNoteEntity(
      id: adjustmentNoteBloc.getAdjustmentNoteEntity.id,
      adjustmentNoteNumber: int.parse(numberController.text),
      documentNumber: documentNumberController.text == ''
          ? numberController.text
          : documentNumberController.text,
      adjustmentNoteType: adjustmentNoteType,
      date: dateController.text,
      dueDate: dueDateController.text,
      status: status.name,
      description: descriptionController.text,
      primaryAccount: primaryAccountController,
      secondaryAccount: secondaryAccountController,
      taxAccount: taxAccountController,
      taxAmount: double.tryParse(taxAmountController.text),
      subTotal: double.parse(subTotalController.text),
      total: double.parse(totalController.text),
    );
  }

  bool validateForm() {
    if (numberController.text.isEmpty ||
        dateController.text.isEmpty ||
        primaryAccountController.id == null ||
        secondaryAccountController.id == null ||
        taxAccountController.id == null) {
      return false;
    }

    return true;
  }

  updateTotalController(PlutoGridController plutoGridController) async {
    totalController.text = plutoGridController.columnSum('total').toString();
    plutoGridController.stateManager!.notifyListeners();
  }

  void onUpdateSubController(subTotal) {
    subTotal = double.tryParse(subTotal) ?? 0;
    double taxAmount = FormatterClass.calculateTaxAmount(subTotal);
    taxAmountController.text = taxAmount.toString();

    double total = FormatterClass.calculateTotalWithTax(subTotal);
    totalController.text = total.toString();
  }
}
