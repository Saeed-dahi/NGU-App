import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/bloc/invoice_bloc.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  late final InvoiceBloc _invoiceBloc;

  @override
  void initState() {
    _invoiceBloc = sl<InvoiceBloc>()..add(const ShowInvoiceEvent(invoiceId: 1));
    super.initState();
  }

  @override
  void dispose() {
    _invoiceBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () => Future.value(),
      child: BlocProvider(
        create: (context) => _invoiceBloc,
        child: BlocConsumer<InvoiceBloc, InvoiceState>(
          builder: (context, state) {
            if (state is LoadingInvoiceState) {
              return Center(child: Loaders.loading());
            }
            if (state is ErrorInvoiceState) {
              return Center(child: MessageScreen(text: state.error));
            }
            return const SizedBox();
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
