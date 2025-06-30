import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_cost_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/get_invoice_cost_use_case.dart';

part 'invoice_cost_event.dart';
part 'invoice_cost_state.dart';

class InvoiceCostBloc extends Bloc<InvoiceCostEvent, InvoiceCostState> {
  final GetInvoiceCostUseCase getInvoiceCostUseCase;
  InvoiceCostBloc({required this.getInvoiceCostUseCase})
      : super(InvoiceCostInitial()) {
    on<GetInvoiceCostEvent>(_getInvoiceCost);
  }

  FutureOr<void> _getInvoiceCost(
      GetInvoiceCostEvent event, Emitter<InvoiceCostState> emit) async {
    emit(LoadingInvoiceCostState());
    final result = await getInvoiceCostUseCase(event.invoiceId);
    result.fold((failure) {
      emit(ErrorInvoiceCostState(message: failure.errors['error']));
    }, (data) {
      emit(LoadedInvoiceCostState(invoiceCostEntity: data));
    });
  }
}
