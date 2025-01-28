import 'package:flutter/widgets.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/bloc/invoice_bloc.dart';

class CreateInvoicePage extends StatefulWidget {
  const CreateInvoicePage({super.key});

  @override
  State<CreateInvoicePage> createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage> {
  late final InvoiceBloc _invoiceBloc;

  @override
  void initState() {
    _invoiceBloc = sl<InvoiceBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
