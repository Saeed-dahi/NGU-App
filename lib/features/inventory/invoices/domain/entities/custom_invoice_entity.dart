import 'package:equatable/equatable.dart';

class CustomInvoiceEntity extends Equatable {
  final int id;
  final int invoiceNumber;
  final String invoiceType;
  final String date;
  final String dueDate;
  final String status;
  final String invoiceNature;
  final String currency;
  final double subTotal;
  final double total;
  final String? notes;
  // final InvoiceAccountEntity account;

  const CustomInvoiceEntity({
    required this.id,
    required this.invoiceNumber,
    required this.invoiceType,
    required this.date,
    required this.dueDate,
    required this.status,
    required this.invoiceNature,
    required this.currency,
    required this.subTotal,
    required this.total,
    required this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        invoiceNumber,
        invoiceType,
        date,
        dueDate,
        status,
        invoiceNature,
        currency,
        subTotal,
        total,
        notes,
      ];
}
