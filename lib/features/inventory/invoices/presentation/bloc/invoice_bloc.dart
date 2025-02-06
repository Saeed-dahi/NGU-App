import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/features/accounts/domain/use_cases/get_accounts_name_use_case.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/params/invoice_items_entity_params.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/create_invoice_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/get_all_invoices_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/get_create_invoice_form_data_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/show_invoice_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/update_invoice_use_case.dart';

import 'package:pluto_grid_plus/pluto_grid_plus.dart';
part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final GetAllInvoicesUseCase getAllInvoicesUseCase;
  final ShowInvoiceUseCase showInvoiceUseCase;
  final CreateInvoiceUseCase createInvoiceUseCase;
  final UpdateInvoiceUseCase updateInvoiceUseCase;
  final GetAccountsNameUseCase getAccountsNameUseCase;
  final GetCreateInvoiceFormDataUseCase getCreateInvoiceFormDataUseCase;

  late InvoiceEntity _invoiceEntity;
  InvoiceEntity get getInvoiceEntity => _invoiceEntity;

  Map<String, dynamic> _accountsName = {};
  Map<String, dynamic> get accountsName => _accountsName;

  List<String> _accountsNameList = [];
  List<String> get accountsNameList => _accountsNameList;

  Map<String, dynamic> _validationErrors = {};
  Map<String, dynamic> get getValidationErrors => _validationErrors;

  late PlutoGridStateManager _stateManager;
  PlutoGridStateManager get getStateManger => _stateManager;
  set setStateManager(PlutoGridStateManager sts) => _stateManager = sts;

  String? natureController;

  List<InvoiceItemsEntityParams> get invoiceItems {
    return _stateManager.rows.map((row) {
      return InvoiceItemsEntityParams(
          productUnitId: row.cells['code']?.value,
          quantity:
              FormatterClass.doubleFormatter(row.cells['quantity']?.value),
          price: FormatterClass.doubleFormatter(row.cells['price']?.value));
    }).toList();
  }

  InvoiceBloc(
      {required this.getAllInvoicesUseCase,
      required this.showInvoiceUseCase,
      required this.createInvoiceUseCase,
      required this.updateInvoiceUseCase,
      required this.getAccountsNameUseCase,
      required this.getCreateInvoiceFormDataUseCase})
      : super(InvoiceInitial()) {
    on<GetAllInvoiceEvent>(_getAllInvoices);
    on<ShowInvoiceEvent>(_showInvoice);
    on<CreateInvoiceEvent>(_createInvoice);
    on<UpdateInvoiceEvent>(_updateInvoice);
    on<GetCreateInvoiceFormData>(_createFormData);
    on<GetAccountsNameEvent>(_getAccountNameEvent);
  }

  FutureOr<void> _getAllInvoices(
      GetAllInvoiceEvent event, Emitter<InvoiceState> emit) async {
    emit(LoadingInvoiceState());

    final result = await getAllInvoicesUseCase(event.type);
    result.fold((failure) {
      emit(ErrorInvoiceState(error: failure.errors['error']));
    }, (data) {
      emit(LoadedAllInvoicesState(invoices: data));
    });
  }

  FutureOr<void> _showInvoice(
      ShowInvoiceEvent event, Emitter<InvoiceState> emit) async {
    emit(LoadingInvoiceState());
    final result =
        await showInvoiceUseCase(event.invoiceId, event.direction, event.type);
    result.fold((failure) {
      emit(ErrorInvoiceState(error: failure.errors['error']));
    }, (data) {
      _invoiceEntity = data;
      emit(LoadedInvoiceState(invoice: _invoiceEntity));
    });
  }

  FutureOr<void> _createInvoice(
      CreateInvoiceEvent event, Emitter<InvoiceState> emit) async {
    emit(LoadingInvoiceState());

    final result = await createInvoiceUseCase(event.invoice, invoiceItems);
    _createAndUpdateFoldResult(result, event, emit);
    _invoiceEntity = event.invoice;
  }

  FutureOr<void> _updateInvoice(
      UpdateInvoiceEvent event, Emitter<InvoiceState> emit) async {
    emit(LoadingInvoiceState());

    final result = await updateInvoiceUseCase(event.invoice, invoiceItems);

    _createAndUpdateFoldResult(result, event, emit);
  }

  FutureOr<void> _getAccountNameEvent(
      GetAccountsNameEvent event, Emitter emit) async {
    final result = await getAccountsNameUseCase();

    result.fold((failure) {
      emit(ErrorInvoiceState(error: AppStrings.unKnown.tr));
    }, (data) {
      _accountsName = data;
      _accountsNameList = data.entries
          .map(
            (e) => !e.key.startsWith('id')
                ? '${e.key} - ${e.value.toString()}'
                : '',
          )
          .toList();
    });
  }

  void _createAndUpdateFoldResult(Either<Failure, InvoiceEntity> result, event,
      Emitter<InvoiceState> emit) {
    result.fold((failure) {
      if (failure is ValidationFailure) {
        _validationErrors = failure.errors;
        emit(LoadedInvoiceState(invoice: _invoiceEntity));
      } else {
        emit(ErrorInvoiceState(error: failure.errors['error']));
      }
    }, (data) {
      _invoiceEntity = data;
      _validationErrors = {};
      emit(LoadedInvoiceState(invoice: data));
    });
  }

  FutureOr<void> _createFormData(
      GetCreateInvoiceFormData event, Emitter<InvoiceState> emit) async {
    final result = await getCreateInvoiceFormDataUseCase(event.type);

    result.fold((failure) {}, (data) {
      _invoiceEntity = data;
      natureController = null;
      emit(LoadedInvoiceState(invoice: data));
    });
  }

  int getDesiredId(
    String value,
  ) {
    var spitedValue = value.split('-');
    var desiredId =
        int.parse(accountsName['id_${spitedValue[0].removeAllWhitespace}']);

    return desiredId;
  }
}
