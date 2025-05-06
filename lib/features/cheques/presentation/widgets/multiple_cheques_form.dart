import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/custom_radio_button.dart';

import 'package:ngu_app/features/cheques/presentation/blocs/multiple_cheques_cubit/multiple_cheques_cubit.dart';

class MultipleChequesForm extends StatelessWidget {
  final MultipleChequesCubit multipleChequesCubit;

  const MultipleChequesForm({
    super.key,
    required this.multipleChequesCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => multipleChequesCubit,
      child: BlocBuilder<MultipleChequesCubit, MultipleChequesState>(
        builder: (context, state) {
          return Form(
            child: Table(
              children: [
                TableRow(children: [
                  Column(
                    children: [
                      CustomInputField(
                        inputType: TextInputType.name,
                        controller: multipleChequesCubit.chequesCountController,
                        label: 'cheques_count'.tr,
                        format: FilteringTextInputFormatter.digitsOnly,
                        onChanged: (v) => multipleChequesCubit.changeAnyField(),
                      ),
                      CustomInputField(
                        inputType: TextInputType.name,
                        controller: multipleChequesCubit.eachPaymentController,
                        label: 'each_payment'.tr,
                        format: FilteringTextInputFormatter.digitsOnly,
                        onChanged: (v) => multipleChequesCubit.changeAnyField(),
                      ),
                      CustomInputField(
                        inputType: TextInputType.name,
                        controller: multipleChequesCubit.firstPaymentController,
                        label: 'first_payment'.tr,
                        format: FilteringTextInputFormatter.digitsOnly,
                        onChanged: (v) => multipleChequesCubit.changeAnyField(),
                      ),
                      CustomInputField(
                        inputType: TextInputType.name,
                        controller: multipleChequesCubit.lastPaymentController,
                        label: 'last_payment'.tr,
                        format: FilteringTextInputFormatter.digitsOnly,
                        onChanged: (v) => multipleChequesCubit.changeAnyField(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomRadioButton(
                        data: getEnumValues(ChequePaymentCases.values),
                        label: 'payment_way'.tr,
                        selectedValue: multipleChequesCubit.paymentWay,
                        onChanged: (p0) {
                          multipleChequesCubit.changeSelectedPaymentWay(p0!);
                        },
                      ),
                      Visibility(
                        visible: multipleChequesCubit
                                .paymentWayCountController.text ==
                            '0',
                        child: CustomInputField(
                          inputType: TextInputType.name,
                          controller:
                              multipleChequesCubit.paymentWayCountController,
                          label: 'specific_count'.tr,
                          format: FilteringTextInputFormatter.digitsOnly,
                        ),
                      ),
                    ],
                  ),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }
}
