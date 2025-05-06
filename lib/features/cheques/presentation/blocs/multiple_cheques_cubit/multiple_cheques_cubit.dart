import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/utils/enums.dart';

part 'multiple_cheques_state.dart';

class MultipleChequesCubit extends Cubit<MultipleChequesState> {
  TextEditingController chequesCountController = TextEditingController();
  TextEditingController eachPaymentController = TextEditingController();
  TextEditingController firstPaymentController = TextEditingController();
  TextEditingController lastPaymentController = TextEditingController();

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
      eachPayment = (chequeAmount - firstPayment - lastPayment) / chequesCount;
      eachPaymentController.text = eachPayment.toString();
    }
  }
}
