part of 'invoice_form_cubit.dart';

sealed class InvoiceFormState extends Equatable {
  const InvoiceFormState();

  @override
  List<Object> get props => [];
}

final class InvoiceFormInitial extends InvoiceFormState {}
