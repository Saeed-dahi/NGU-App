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
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_cost_bloc/invoice_cost_bloc.dart';

import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoice_cost_pluto_table.dart';

class InvoiceCostPage extends StatefulWidget {
  final bool enableEditing;
  final Map<String, dynamic> errors;
  final int invoiceId;

  const InvoiceCostPage({
    super.key,
    required this.enableEditing,
    required this.errors,
    required this.invoiceId,
  });

  @override
  State<InvoiceCostPage> createState() => _InvoiceCostPageState();
}

class _InvoiceCostPageState extends State<InvoiceCostPage> {
  late final InvoiceCostBloc _invoiceCostBloc;

  @override
  void initState() {
    _invoiceCostBloc = sl<InvoiceCostBloc>()
      ..add(GetInvoiceCostEvent(invoiceId: widget.invoiceId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _invoiceCostBloc,
      child: BlocBuilder<InvoiceCostBloc, InvoiceCostState>(
        builder: (context, state) {
          if (state is LoadedInvoiceCostState) {
            return _pageBody(state);
          }
          if (state is ErrorInvoiceCostState) {
            return MessageScreen(text: state.message);
          }
          return Loaders.loading();
        },
      ),
    );
  }

  Column _pageBody(LoadedInvoiceCostState state) {
    return Column(
      children: [
        Table(
          children: [
            TableRow(
              children: [
                CustomAccountAutoComplete(
                  enabled: widget.enableEditing,
                  initialValue: '',
                  error: widget.errors['agent_id']?.join('\n'),
                  controller: TextEditingController(),
                  label: 'agent_account'.tr,
                ),
                CustomAccountAutoComplete(
                  enabled: widget.enableEditing,
                  initialValue: '',
                  controller: TextEditingController(),
                  error: widget.errors['commission_account_id']?.join('\n'),
                  label: 'commission_account'.tr,
                ),
                CustomDropdown(
                  dropdownValue: getEnumValues(InvoiceCommissionType.values),
                  label: 'commission_type'.tr,
                  enabled: widget.enableEditing,
                  required: true,
                  onChanged: (value) {},
                ),
                CustomInputField(
                  label: 'commission_rate'.tr,
                  enabled: widget.enableEditing,
                ),
                CustomInputField(
                  label: 'commission_amount'.tr,
                  readOnly: true,
                  required: false,
                ),
                CustomIconButton(
                  color: AppColors.primaryColor,
                  tooltip: 'refresh'.tr,
                  onPressed: () {},
                  icon: Icons.refresh_outlined,
                ),
              ],
            ),
          ],
        ),
        CustomInvoiceCostPlutoTable(
            invoiceCostItems: state.invoiceCostEntity.items!),
      ],
    );
  }
}
