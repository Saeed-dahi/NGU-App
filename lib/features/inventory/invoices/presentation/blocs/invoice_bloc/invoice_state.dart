part of 'invoice_bloc.dart';

sealed class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object> get props => [];
}

final class InvoiceInitial extends InvoiceState {}

class LoadedAllInvoicesState extends InvoiceState {
  final List<InvoiceEntity> invoices;

  const LoadedAllInvoicesState({required this.invoices});

  @override
  List<Object> get props => [invoices];
}

class LoadedInvoiceState extends InvoiceState {
  final InvoiceEntity invoice;

  const LoadedInvoiceState({required this.invoice});
  @override
  List<Object> get props => [invoice];
}

class LoadingInvoiceState extends InvoiceState {}

class CreatedInvoiceState extends InvoiceState {}

class ErrorInvoiceState extends InvoiceState {
  final String error;

  const ErrorInvoiceState({required this.error});
  @override
  List<Object> get props => [error];
}
