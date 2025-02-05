import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/features/accounts/domain/use_cases/get_accounts_name_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/params/invoice_items_entity_params.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/create_invoice_use_case.dart';
import 'package:ngu_app/features/inventory/invoices/domain/use_cases/get_all_invoices_use_case.dart';
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

  List<Map> get invoiceItems {
    // return _stateManager.rows.where((row) {
    //   final productUnitId = row.cells['account_code']?.value;
    //   final quantity =      row.cells['quantity']?.value;
    //   final price =         row.cells['price']?.value;

    //   return productUnitId != null &&
    //       productUnitId.toString().isNotEmpty &&
    //       quantity != null &&
    //       quantity.toString().isNotEmpty;
    // }).map((row) {
    //   return {};
    // }).toList();
    return _stateManager.rows.map((row) {
      return {
        'product_unit_id': row.cells['account_code']?.value,
        'quantity': row.cells['quantity']?.value,
        'price': row.cells['price']?.value
      };
    }).toList();
  }

  InvoiceBloc(
      {required this.getAllInvoicesUseCase,
      required this.showInvoiceUseCase,
      required this.createInvoiceUseCase,
      required this.updateInvoiceUseCase,
      required this.getAccountsNameUseCase})
      : super(InvoiceInitial()) {
    on<GetAllInvoiceEvent>(_getAllInvoices);
    on<ShowInvoiceEvent>(_showInvoice);
    on<CreateInvoiceEvent>(_createInvoice);
    on<UpdateInvoiceEvent>(_updateInvoice);

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

    final result = await createInvoiceUseCase(event.invoice, []);
    result.fold((failure) {}, (data) {});
  }

  FutureOr<void> _updateInvoice(
      UpdateInvoiceEvent event, Emitter<InvoiceState> emit) async {
    emit(LoadingInvoiceState());

    final result = await updateInvoiceUseCase(event.invoice, [
      const InvoiceItemsEntityParams(
          productUnitId: 1, description: '1', price: 10, quantity: 20)
    ]);

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

  int getDesiredId(
    String value,
  ) {
    var spitedValue = value.split('-');
    var desiredId =
        int.parse(accountsName['id_${spitedValue[0].removeAllWhitespace}']);

    return desiredId;
  }
}
