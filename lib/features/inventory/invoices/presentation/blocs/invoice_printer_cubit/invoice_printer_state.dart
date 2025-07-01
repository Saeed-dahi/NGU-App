part of 'invoice_printer_cubit.dart';

sealed class InvoicePrinterState extends Equatable {
  const InvoicePrinterState();

  @override
  List<Object> get props => [];
}

final class InvoicePrinterInitial extends InvoicePrinterState {}
