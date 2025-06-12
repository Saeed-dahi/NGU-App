import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_account_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_entity.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_bloc/adjustment_note_bloc.dart';

part 'adjustment_note_form_state.dart';

class AdjustmentNoteFormCubit extends Cubit<AdjustmentNoteFormState> {
  final String invoiceType;

  TextEditingController numberController = TextEditingController();
  TextEditingController documentNumberController = TextEditingController();
  final TextEditingController invoiceSearchNumController =
      TextEditingController();

  late TextEditingController dateController = TextEditingController();
  late TextEditingController dueDateController = TextEditingController();
  late TextEditingController notesController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  late AdjustmentNoteAccountEntity accountController;

  late AdjustmentNoteAccountEntity goodsAccountController;

  late AdjustmentNoteAccountEntity taxAccountController;
  late TextEditingController taxAmountController = TextEditingController();

  late AdjustmentNoteAccountEntity discountAccountController;
  late TextEditingController discountPercentageController =
      TextEditingController();
  late TextEditingController discountAmountController = TextEditingController();
  late TextEditingController totalController = TextEditingController();
  late TextEditingController subTotalAfterDiscountController =
      TextEditingController();

  String? natureController;

  final AdjustmentNoteBloc invoiceBloc;
  AdjustmentNoteFormCubit(
      {required this.invoiceBloc, required this.invoiceType})
      : super(AdjustmentNoteFormInitial());

  initControllers(AdjustmentNoteEntity invoice) {
    numberController =
        TextEditingController(text: invoice.invoiceNumber.toString());
    documentNumberController =
        TextEditingController(text: invoice.documentNumber.toString());
    dateController = TextEditingController(text: invoice.date);
    dueDateController = TextEditingController(text: invoice.dueDate);
    notesController = TextEditingController(text: invoice.notes);
    accountController = invoice.account!;
    addressController = TextEditingController(text: invoice.address);
    descriptionController = TextEditingController(text: invoice.description);

    goodsAccountController = invoice.goodsAccount!;

    taxAccountController = invoice.taxAccount!;

    taxAmountController =
        TextEditingController(text: invoice.taxAmount.toString());

    discountAccountController = invoice.discountAccount!;
    totalController.text = invoice.total.toString();
    subTotalAfterDiscountController.text = invoice.subTotal.toString();

    initDiscountsController(invoice);
  }

  disposeControllers() {
    dateController.dispose();
    dueDateController.dispose();
    notesController.dispose();
    numberController.dispose();
    documentNumberController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    taxAmountController.dispose();
    discountPercentageController.dispose();
    discountAmountController.dispose();
    totalController.dispose();
  }

  AdjustmentNoteEntity invoiceEntity(Enum status) {
    return AdjustmentNoteEntity(
        id: invoiceBloc.getAdjustmentNoteEntity.id,
        invoiceNumber: int.parse(numberController.text),
        documentNumber: documentNumberController.text == ''
            ? numberController.text
            : documentNumberController.text,
        invoiceType: invoiceType,
        date: dateController.text,
        dueDate: dueDateController.text,
        status: status.name,
        invoiceNature: natureController,
        address: addressController.text,
        notes: notesController.text,
        description: descriptionController.text,
        account: accountController,
        goodsAccount: goodsAccountController,
        taxAccount: taxAccountController,
        taxAmount: double.tryParse(taxAmountController.text) ?? 5,
        discountAccount: discountAccountController,
        discountAmount: getDiscountValue(),
        discountType: getDiscountType());
  }

  bool validateForm() {
    if (numberController.text.isEmpty ||
        dateController.text.isEmpty ||
        accountController.id == null ||
        goodsAccountController.id == null ||
        taxAccountController.id == null ||
        discountAccountController.id == null) {
      return false;
    }

    return true;
  }

  updateTotalController(PlutoGridController plutoGridController) async {
    totalController.text = plutoGridController.columnSum('total').toString();
    plutoGridController.stateManager!.notifyListeners();
  }

  initDiscountsController(AdjustmentNoteEntity invoice) async {
    if (invoice.discountType == DiscountType.amount.name) {
      discountAmountController =
          TextEditingController(text: invoice.discountAmount.toString());
    } else {
      discountPercentageController =
          TextEditingController(text: invoice.discountAmount.toString());
    }
  }

  onChangeDiscountValue(
      bool isPercentage, PlutoGridController plutoGridController) {
    double subTotal = plutoGridController.columnSum('sub_total');
    if (isPercentage) {
      getSubTotalAfterDiscount(isPercentage, subTotal);
      discountAmountController.text = '0';
    } else {
      getSubTotalAfterDiscount(isPercentage, subTotal);
      discountPercentageController.text = '0';
    }

    totalController.text = FormatterClass.calculateTax(
            taxAmountController.text, subTotalAfterDiscountController.text)
        .toString();
  }

  String? getDiscountType() {
    if (discountPercentageController.text == '0') {
      return DiscountType.amount.name;
    }
    if (discountAmountController.text == '0') {
      return DiscountType.percentage.name;
    }
    return null;
  }

  double? getDiscountValue() {
    if (discountPercentageController.text == '0') {
      return double.tryParse(discountAmountController.text);
    }
    if (discountAmountController.text == '0') {
      return double.tryParse(discountPercentageController.text);
    }
    return 0;
  }

  double getSubTotalAfterDiscount(bool isPercentage, double subTotal) {
    double discountAmount = 0;
    if (isPercentage) {
      discountAmount = FormatterClass.getDiscountMultiplier(
          discountPercentageController.text);

      subTotalAfterDiscountController.text =
          (subTotal * discountAmount).toString();
    } else {
      discountAmount = double.tryParse(discountAmountController.text) ?? 0;
      subTotalAfterDiscountController.text =
          (subTotal - discountAmount).toString();
    }

    return double.tryParse(subTotalAfterDiscountController.text) ?? 0;
  }
}
