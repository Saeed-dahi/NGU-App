import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/features/cheques/domain/entities/params/multiple_cheques_params_entity.dart';

part 'multiple_cheques_state.dart';

class MultipleChequesCubit extends Cubit<MultipleChequesState> {
  TextEditingController chequesCountController =
      TextEditingController(text: '1');
  TextEditingController eachPaymentController =
      TextEditingController(text: '0');
  TextEditingController firstPaymentController =
      TextEditingController(text: '0');
  TextEditingController lastPaymentController =
      TextEditingController(text: '0');

  String? paymentWay;
  TextEditingController paymentWayCountController = TextEditingController();

  double chequeAmount = 0;

  MultipleChequesCubit() : super(MultipleChequesInitial());

  void changeSelectedPaymentWay(String selectedValue) {
    paymentWay = selectedValue;

    paymentWayCountController.text = '';
    if (selectedValue == ChequePaymentCases.specific_days.name ||
        selectedValue == ChequePaymentCases.specific_months.name) {
      paymentWayCountController.text = '0';
    }

    emit(ChangeSelectedPaymentWay(selectedValue: selectedValue));
  }

  void changeAnyField() {
    double chequesCount = double.tryParse(chequesCountController.text) ?? 1;
    double eachPayment = double.tryParse(eachPaymentController.text) ?? 0;
    double firstPayment = double.tryParse(firstPaymentController.text) ?? 0;
    double lastPayment = double.tryParse(lastPaymentController.text) ?? 0;

    if (chequeAmount != 0) {
      var n = 0;
      if (firstPayment != 0) n++;
      if (lastPayment != 0) n++;
      eachPayment =
          (chequeAmount - firstPayment - lastPayment) / (chequesCount - n);
      eachPaymentController.text = eachPayment.toString();
    }
  }

  MultipleChequesParamsEntity getMultipleChequeParamsEntity() {
    return MultipleChequesParamsEntity(
        chequesCount: double.parse(chequesCountController.text),
        eachPayment: double.parse(eachPaymentController.text),
        firstPayment: double.parse(firstPaymentController.text),
        lastPayment: double.parse(lastPaymentController.text),
        paymentWay: paymentWay!,
        paymentWayCount: double.tryParse(paymentWayCountController.text) ?? 0);
  }
}
