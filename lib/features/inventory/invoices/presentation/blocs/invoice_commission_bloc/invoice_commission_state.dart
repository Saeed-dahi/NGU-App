part of 'invoice_commission_bloc.dart';

sealed class InvoiceCommissionState extends Equatable {
  const InvoiceCommissionState();

  @override
  List<Object> get props => [];
}

final class InvoiceCommissionInitial extends InvoiceCommissionState {}

class CreatedInvoiceCommissionState extends InvoiceCommissionState {}

class ErrorInvoiceCommissionState extends InvoiceCommissionState {
  final String error;

  const ErrorInvoiceCommissionState({required this.error});
  @override
  List<Object> get props => [error];
}

class LoadedInvoiceCommissionState extends InvoiceCommissionState {
  final InvoiceCommissionEntity invoiceCommission;

  const LoadedInvoiceCommissionState({required this.invoiceCommission});

  @override
  List<Object> get props => [invoiceCommission];
}

class ValidationErrorState extends InvoiceCommissionState {
  final Map<String, dynamic> validationErrors;

  const ValidationErrorState({required this.validationErrors});

  @override
  List<Object> get props => [validationErrors];
}
