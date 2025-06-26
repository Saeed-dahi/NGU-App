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
      'cheques_count': chequesCount,
      'each_payment': eachPayment,
      'first_payment': firstPayment,
      'last_payment': lastPayment,
      'payment_way': paymentWay,
      'payment_way_count': paymentWayCount
    };
  }
}
