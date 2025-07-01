import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_account_auto_complete.dart';
import 'package:ngu_app/core/widgets/custom_dropdown.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';

import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_commission_bloc/invoice_commission_bloc.dart';

class InvoiceCommissionFields extends StatelessWidget {
  final bool enableEditing;

  const InvoiceCommissionFields({super.key, required this.enableEditing});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<InvoiceCommissionBloc>()
        ..add(const GetInvoiceCommissionEvent(invoiceId: 1)),
      child: BlocBuilder<InvoiceCommissionBloc, InvoiceCommissionState>(
        builder: (context, state) {
          if (state is LoadedInvoiceCommissionState) {
            return _pageBody(context);
          }
          if (state is ErrorInvoiceCommissionState) {
            return MessageScreen(text: state.error);
          }
          return Loaders.loading();
        },
      ),
    );
  }

  Table _pageBody(BuildContext context) {
    context.read<InvoiceCommissionBloc>().initControllers();
    return Table(
      children: [
        TableRow(
          children: [
            CustomAccountAutoComplete(
              enabled: enableEditing,
              initialValue:
                  context.read<InvoiceCommissionBloc>().agentAccount.arName!,
              // error: enableEditing.errors['agent_id']?.join('\n'),
              controller: context.read<InvoiceCommissionBloc>().agentAccount,
              label: 'agent_account'.tr,
            ),
            CustomAccountAutoComplete(
              enabled: enableEditing,
              initialValue: context
                  .read<InvoiceCommissionBloc>()
                  .commissionAccount
                  .arName!,
              controller:
                  context.read<InvoiceCommissionBloc>().commissionAccount,
              // error: enableEditing.errors['commission_account_id']?.join('\n'),
              label: 'commission_account'.tr,
            ),
            CustomDropdown(
              dropdownValue: getEnumValues(InvoiceCommissionType.values),
              label: 'commission_type'.tr,
              enabled: enableEditing,
              required: true,
              value: context.read<InvoiceCommissionBloc>().type,
              onChanged: (value) {
                context.read<InvoiceCommissionBloc>().type = value;
              },
            ),
            CustomInputField(
              label: 'commission_rate'.tr,
              enabled: enableEditing,
              controller: context.read<InvoiceCommissionBloc>().rate,
            ),
            CustomInputField(
              label: 'commission_amount'.tr,
              readOnly: true,
              required: false,
              controller: context.read<InvoiceCommissionBloc>().amount,
            ),
            CustomIconButton(
              color: AppColors.primaryColor,
              tooltip: 'refresh'.tr,
              onPressed: () {
                context
                    .read<InvoiceCommissionBloc>()
                    .add(const GetInvoiceCommissionEvent(invoiceId: 1));
              },
              icon: Icons.refresh_outlined,
            ),
          ],
        ),
      ],
    );
  }
}
