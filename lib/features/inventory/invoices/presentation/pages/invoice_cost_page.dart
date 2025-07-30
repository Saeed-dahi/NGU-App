import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_cost_bloc/invoice_cost_bloc.dart';

import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoice_cost_pluto_table.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/invoice_commission_fields.dart';

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
          return Center(child: Loaders.loading());
        },
      ),
    );
  }

  ListView _pageBody(LoadedInvoiceCostState state) {
    return ListView(
      children: [
        // InvoiceCommissionFields(
        //   enableEditing: widget.enableEditing,
        //   invoiceId: widget.invoiceId,
        // ),
        CustomInvoiceCostPlutoTable(invoiceCost: state.invoiceCostEntity),
      ],
    );
  }
}
