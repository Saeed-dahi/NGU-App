import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_account_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_bloc/invoice_bloc.dart';

part 'invoice_form_state.dart';

class InvoiceFormCubit extends Cubit<InvoiceFormState> {
  final String invoiceType;

  TextEditingController numberController = TextEditingController();
  final TextEditingController invoiceSearchNumController =
      TextEditingController();
  late TextEditingController dateController = TextEditingController();
  late TextEditingController dueDateController = TextEditingController();
  late TextEditingController notesController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  late InvoiceAccountEntity accountController;

  late InvoiceAccountEntity goodsAccountController;

  late InvoiceAccountEntity taxAccountController;
  late TextEditingController taxAmountController = TextEditingController();

  late InvoiceAccountEntity discountAccountController;
  late TextEditingController discountAmountController = TextEditingController();

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
    descriptionController = TextEditingController(text: invoice.description);

    goodsAccountController = invoice.goodsAccount!;

    taxAccountController = invoice.taxAccount!;

    taxAmountController =
        TextEditingController(text: invoice.totalTax.toString());

    discountAccountController = invoice.discountAccount!;
    discountAmountController =
        TextEditingController(text: invoice.totalDiscount.toString());
  }

  disposeControllers() {
    dateController.dispose();
    dueDateController.dispose();
    notesController.dispose();
    numberController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    taxAmountController.dispose();
    discountAmountController.dispose();
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
      description: descriptionController.text,
      account: accountController,
      goodsAccount: goodsAccountController,
      taxAccount: taxAccountController,
      totalTax: double.tryParse(taxAmountController.text) ?? 5,
      discountAccount: discountAccountController,
      totalDiscount: double.tryParse(taxAmountController.text) ?? 0,
    );
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
}
