import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/create_invoice_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/get_all_invoices_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/show_invoice_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/update_invoice_use_case.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final GetAllInvoicesUseCase getAllInvoicesUseCase;
  final ShowInvoiceUseCase showInvoiceUseCase;
  final CreateInvoiceUseCase createInvoiceUseCase;
  final UpdateInvoiceUseCase updateInvoiceUseCase;

  InvoiceBloc(
      {required this.getAllInvoicesUseCase,
      required this.showInvoiceUseCase,
      required this.createInvoiceUseCase,
      required this.updateInvoiceUseCase})
      : super(InvoiceInitial()) {
    on<GetAllInvoiceEvent>(_getAllInvoices);
    on<ShowInvoiceEvent>(_showInvoice);
    on<CreateInvoiceEvent>(_createInvoice);
    on<UpdateInvoiceEvent>(_updateInvoice);
  }

  FutureOr<void> _getAllInvoices(
      GetAllInvoiceEvent event, Emitter<InvoiceState> emit) async {
    emit(LoadingInvoiceState());

    final result = await getAllInvoicesUseCase();
    result.fold((failure) {
      print(failure);
    }, (data) {
      print(data);
    });
  }

  FutureOr<void> _showInvoice(
      ShowInvoiceEvent event, Emitter<InvoiceState> emit) async {
    emit(LoadingInvoiceState());

    final result = await showInvoiceUseCase(event.invoiceId, event.direction);
    result.fold((failure) {
      emit(ErrorInvoiceState(error: failure.errors['error']));
    }, (data) {
      emit(LoadedInvoiceState(invoice: data));
    });
  }

  FutureOr<void> _createInvoice(
      CreateInvoiceEvent event, Emitter<InvoiceState> emit) async {
    emit(LoadingInvoiceState());

    final result = await createInvoiceUseCase(event.invoice);
    result.fold((failure) {
      print(failure);
    }, (data) {
      print(data);
    });
  }

  FutureOr<void> _updateInvoice(
      UpdateInvoiceEvent event, Emitter<InvoiceState> emit) async {
    emit(LoadingInvoiceState());

    final result = await updateInvoiceUseCase(event.invoice);
    result.fold((failure) {
      print(failure);
    }, (data) {
      print(data);
    });
  }
}
