import 'package:ngu_app/features/cheques/domain/entities/params/multiple_cheques_params_entity.dart';

class MultipleChequesParamsModel extends MultipleChequesParamsEntity {
  const MultipleChequesParamsModel(
      {required super.chequesCount,
      required super.eachPayment,
      required super.firstPayment,
      required super.lastPayment,
      required super.paymentWay,
      required super.paymentWayCount});

  Map<String, dynamic> toJson() {
    return {
      'chequesCount': chequesCount,
      'eachPayment': eachPayment,
      'firstPayment': firstPayment,
      'lastPayment': lastPayment,
      'paymentWay': paymentWay,
      'paymentWayCount': paymentWayCount
    };
  }
}
