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
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_commission_bloc/invoice_commission_bloc.dart';

class InvoiceCommissionFields extends StatefulWidget {
  final bool enableEditing;
  final int invoiceId;

  const InvoiceCommissionFields(
      {super.key, required this.enableEditing, required this.invoiceId});

  @override
  State<InvoiceCommissionFields> createState() =>
      _InvoiceCommissionFieldsState();
}

class _InvoiceCommissionFieldsState extends State<InvoiceCommissionFields> {
  late InvoiceCommissionBloc _invoiceCommissionBloc;

  @override
  void initState() {
    _invoiceCommissionBloc = sl<InvoiceCommissionBloc>()
      ..add(const GetInvoiceCommissionEvent(invoiceId: 1));
    super.initState();
  }

  @override
  void dispose() {
    _invoiceCommissionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _invoiceCommissionBloc,
      child: BlocBuilder<InvoiceCommissionBloc, InvoiceCommissionState>(
        builder: (context, state) {
          if (state is LoadedInvoiceCommissionState ||
              state is ValidationErrorState) {
            return _pageBody(context);
          }
          if (state is ErrorInvoiceCommissionState) {
            return _pageBody(context, isCreate: true);
          }

          return Center(child: Loaders.loading());
        },
      ),
    );
  }

  Table _pageBody(BuildContext context, {bool isCreate = false}) {
    _invoiceCommissionBloc.initControllers();
    return Table(
      children: [
        TableRow(
          children: [
            CustomAccountAutoComplete(
              enabled: widget.enableEditing,
              initialValue: _invoiceCommissionBloc.agentAccount.arName ?? '',
              error: _invoiceCommissionBloc.getValidationErrors['agent_id']
                  ?.join('\n'),
              controller: _invoiceCommissionBloc.agentAccount,
              label: 'agent_account'.tr,
            ),
            CustomAccountAutoComplete(
              enabled: widget.enableEditing,
              initialValue:
                  _invoiceCommissionBloc.commissionAccount.arName ?? '',
              error: _invoiceCommissionBloc
                  .getValidationErrors['commission_account_id']
                  ?.join('\n'),
              controller: _invoiceCommissionBloc.commissionAccount,
              label: 'commission_account'.tr,
            ),
            CustomDropdown(
              dropdownValue: getEnumValues(InvoiceCommissionType.values),
              label: 'commission_type'.tr,
              enabled: widget.enableEditing,
              required: true,
              value: _invoiceCommissionBloc.type,
              error: _invoiceCommissionBloc
                  .getValidationErrors['commission_type']
                  ?.join('\n'),
              onChanged: (value) {
                _invoiceCommissionBloc.type = value;
              },
            ),
            CustomInputField(
              label: 'commission_rate'.tr,
              enabled: widget.enableEditing,
              controller: _invoiceCommissionBloc.rate,
              error: _invoiceCommissionBloc
                  .getValidationErrors['commission_rate']
                  ?.join('\n'),
            ),
            CustomInputField(
              label: 'commission_amount'.tr,
              readOnly: true,
              required: false,
              controller: _invoiceCommissionBloc.amount,
            ),
            if (!isCreate)
              CustomIconButton(
                color: AppColors.primaryColor,
                tooltip: 'refresh'.tr,
                onPressed: () {
                  _invoiceCommissionBloc.add(
                      GetInvoiceCommissionEvent(invoiceId: widget.invoiceId));
                },
                icon: Icons.refresh_outlined,
              ),
            if (isCreate)
              CustomIconButton(
                color: AppColors.primaryColor,
                tooltip: 'add'.tr,
                onPressed: () {
                  _invoiceCommissionBloc.add(
                      GetInvoiceCommissionEvent(invoiceId: widget.invoiceId));
                },
                icon: Icons.add,
              ),
          ],
        ),
      ],
    );
  }
}
