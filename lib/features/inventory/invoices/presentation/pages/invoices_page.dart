import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';

import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_bloc/invoice_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoices_pluto_table.dart';

class InvoicesPage extends StatefulWidget {
  final String type;
  const InvoicesPage({super.key, required this.type});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  late final InvoiceBloc _invoiceBloc;

  @override
  void initState() {
    _invoiceBloc = sl<InvoiceBloc>()
      ..add(GetAllInvoiceEvent(type: widget.type));
    super.initState();
  }

  @override
  void dispose() {
    _invoiceBloc.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    _invoiceBloc.add(GetAllInvoiceEvent(type: widget.type));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _invoiceBloc,
      child: CustomRefreshIndicator(
        child: ListView(
          children: [
            BlocBuilder<InvoiceBloc, InvoiceState>(
              builder: (context, state) {
                if (state is LoadedAllInvoicesState) {
                  return CustomInvoicesPlutoTable(
                    invoices: state.invoices,
                  );
                }
                if (state is ErrorInvoiceState) {
                  return Center(
                    child: MessageScreen(text: state.error),
                  );
                }
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  child: Center(
                    child: Loaders.loading(),
                  ),
                );
              },
            ),
          ],
        ),
        onRefresh: () => _refresh(),
      ),
    );
  }
}
