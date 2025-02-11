import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_account_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/bloc/invoice_bloc.dart';

part 'invoice_form_state.dart';

class InvoiceFormCubit extends Cubit<InvoiceFormState> {
  final String invoiceType;

  TextEditingController numberController = TextEditingController();
  late TextEditingController dateController = TextEditingController();
  late TextEditingController dueDateController = TextEditingController();
  late TextEditingController notesController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late InvoiceAccountEntity accountController;

  late InvoiceAccountEntity goodsAccountController;
  late TextEditingController goodsAccountDescriptionController =
      TextEditingController();

  late InvoiceAccountEntity taxAccountController;
  late TextEditingController taxAmountController = TextEditingController();
  late TextEditingController taxAccountDescriptionController =
      TextEditingController();

  late InvoiceAccountEntity discountAccountController;
  late TextEditingController discountAmountController = TextEditingController();
  late TextEditingController discountAccountDescriptionController =
      TextEditingController();

  String? natureController;

  final InvoiceBloc invoiceBloc;
  InvoiceFormCubit({required this.invoiceBloc, required this.invoiceType})
      : super(InvoiceFormInitial());

  initControllers(InvoiceEntity invoice) {
    numberController =
        TextEditingController(text: invoice.invoiceNumber.toString());
    dateController = TextEditingController(text: invoice.date);
    dueDateController = TextEditingController(text: invoice.dueDate);
    notesController = TextEditingController(text: invoice.notes);
    accountController = invoice.account!;
    addressController = TextEditingController(text: invoice.address);

    goodsAccountController = invoice.goodsAccount!;
    goodsAccountDescriptionController =
        TextEditingController(text: invoice.goodsAccount!.description);

    taxAccountController = invoice.taxAccount!;
    taxAccountDescriptionController =
        TextEditingController(text: invoice.taxAccount!.description);
    taxAmountController =
        TextEditingController(text: invoice.totalTax.toString());

    discountAccountController = invoice.discountAccount!;
    discountAmountController =
        TextEditingController(text: invoice.totalDiscount.toString());
    discountAccountDescriptionController =
        TextEditingController(text: invoice.discountAccount!.description);
  }

  disposeControllers() {
    dateController.dispose();
    dueDateController.dispose();
    notesController.dispose();
    numberController.dispose();
    addressController.dispose();
    goodsAccountDescriptionController.dispose();
    taxAccountDescriptionController.dispose();
    taxAmountController.dispose();
    discountAmountController.dispose();
    discountAccountDescriptionController.dispose();
  }

  InvoiceEntity invoiceEntity(Enum status) {
    return InvoiceEntity(
      id: invoiceBloc.getInvoiceEntity.id,
      invoiceNumber: int.parse(numberController.text),
      invoiceType: invoiceType,
      date: dateController.text,
      dueDate: dueDateController.text,
      status: status.name,
      invoiceNature: natureController,
      address: addressController.text,
      notes: notesController.text,
      account: accountController,
      goodsAccount: goodsAccountController,
      taxAccount: taxAccountController,
      totalTax: double.tryParse(taxAmountController.text) ?? 5,
      discountAccount: discountAccountController,
      totalDiscount: double.tryParse(taxAmountController.text) ?? 0,
    );
  }

  // InvoiceEntity invoiceEntity(Enum status) {
  //   return InvoiceEntity(
  //     id: _invoiceBloc.getInvoiceEntity.id,
  //     invoiceNumber: int.parse(_numberController.text),
  //     invoiceType: widget.type,
  //     date: _dateController.text,
  //     dueDate: _dueDateController.text,
  //     status: status.name,
  //     invoiceNature: _invoiceBloc.natureController,
  //     address: addressController.text,

  //     notes: _notesController.text,
  //     account: _accountController,
  //     goodsAccount: _goodsAccountController,
  //     taxAccount: _taxAccountController,
  //     totalTax: double.tryParse(_taxAmountController.text) ?? 5,
  //     discountAccount: _discountAccountController,
  //     totalDiscount: double.tryParse(_taxAmountController.text) ?? 0,
  //   );
  // }

  void onSaveAsDraft() {
    invoiceBloc.add(UpdateInvoiceEvent(invoice: invoiceEntity(Status.draft)));
  }

  void onSaveAsSaved() {
    invoiceBloc.add(UpdateInvoiceEvent(invoice: invoiceEntity(Status.saved)));
  }
}
