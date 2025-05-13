import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/cheques/data/models/parmas/multiple_cheques_params_model.dart';

class MultipleChequesParamsEntity extends Equatable {
  final double chequesCount;
  final double eachPayment;
  final double firstPayment;
  final double lastPayment;
  final String paymentWay;
  final double paymentWayCount;

  const MultipleChequesParamsEntity(
      {required this.chequesCount,
      required this.eachPayment,
      required this.firstPayment,
      required this.lastPayment,
      required this.paymentWay,
      required this.paymentWayCount});

  MultipleChequesParamsModel toModel() {
    return MultipleChequesParamsModel(
        chequesCount: chequesCount,
        eachPayment: eachPayment,
        firstPayment: firstPayment,
        lastPayment: lastPayment,
        paymentWay: paymentWay,
        paymentWayCount: paymentWayCount);
  }

  @override
  List<Object?> get props => [
        chequesCount,
        eachPayment,
        firstPayment,
        lastPayment,
        paymentWay,
        paymentWayCount
      ];
}
