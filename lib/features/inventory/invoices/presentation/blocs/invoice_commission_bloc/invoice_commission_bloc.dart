import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_account_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_commission_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/create_invoice_commission_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/get_invoice_commission_use_case.dart';

part 'invoice_commission_event.dart';
part 'invoice_commission_state.dart';

class InvoiceCommissionBloc
    extends Bloc<InvoiceCommissionEvent, InvoiceCommissionState> {
  final GetInvoiceCommissionUseCase getInvoiceCommissionUseCase;
  final CreateInvoiceCommissionUseCase createInvoiceCommissionUseCase;

  Map<String, dynamic> _validationErrors = {};
  Map<String, dynamic> get getValidationErrors => _validationErrors;

  InvoiceCommissionEntity? _commissionEntity;

  late InvoiceAccountEntity agentAccount = InvoiceAccountEntity();
  late InvoiceAccountEntity commissionAccount = InvoiceAccountEntity();
  String? type;
  late TextEditingController rate = TextEditingController();
  late TextEditingController amount = TextEditingController();

  InvoiceCommissionBloc(
      {required this.getInvoiceCommissionUseCase,
      required this.createInvoiceCommissionUseCase})
      : super(InvoiceCommissionInitial()) {
    on<GetInvoiceCommissionEvent>(_getInvoiceCommission);
    on<CreateInvoiceCommissionEvent>(_createInvoiceCommission);
  }

  FutureOr<void> _getInvoiceCommission(GetInvoiceCommissionEvent event,
      Emitter<InvoiceCommissionState> emit) async {
    final result = await getInvoiceCommissionUseCase(event.invoiceId);
    result.fold((failure) {
      emit(ErrorInvoiceCommissionState(error: failure.errors['error']));
    }, (data) {
      _commissionEntity = data;
      emit(LoadedInvoiceCommissionState(invoiceCommission: data));
    });
  }

  FutureOr<void> _createInvoiceCommission(CreateInvoiceCommissionEvent event,
      Emitter<InvoiceCommissionState> emit) async {
    final result = await createInvoiceCommissionUseCase(
        event.invoiceId, event.invoiceCommissionEntity);
    result.fold((failure) {
      if (failure is ValidationFailure) {
        _validationErrors = failure.errors;
        emit(ValidationErrorState(validationErrors: _validationErrors));
      } else {
        emit(ErrorInvoiceCommissionState(error: failure.errors['error']));
      }
    }, (data) {
      _commissionEntity = data;
      emit(LoadedInvoiceCommissionState(invoiceCommission: data));
    });
  }

  initControllers() {
    if (_commissionEntity != null) {
      rate = TextEditingController(text: _commissionEntity!.rate.toString());
      amount =
          TextEditingController(text: _commissionEntity!.amount.toString());
      agentAccount = _commissionEntity!.agentAccount;
      commissionAccount = _commissionEntity!.commissionAccount;
      type = _commissionEntity!.type;
    }
  }

  InvoiceCommissionEntity getCommissionEntity() {
    return InvoiceCommissionEntity(
      agentAccount: agentAccount,
      commissionAccount: commissionAccount,
      rate: double.tryParse(rate.text) ?? 0.0,
      amount: double.tryParse(amount.text) ?? 0.0,
      type: type!,
    );
  }
}
