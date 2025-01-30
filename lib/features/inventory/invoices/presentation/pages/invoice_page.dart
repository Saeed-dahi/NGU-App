import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/bloc/invoice_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/pages/invoice_options_page.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/pages/invoice_print_page.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoice_fields.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoice_pluto_table.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/invoice_tool_bar.dart';

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

  Color _getBackgroundColor(String type) {
    if (InvoiceType.sales.name == type) {
      return Colors.green;
    }
    if (InvoiceType.purchase.name == type) {
      return Colors.white;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () => Future.value(),
      child: BlocProvider(
        create: (context) => _invoiceBloc,
        child: BlocConsumer<InvoiceBloc, InvoiceState>(
          builder: (context, state) {
            if (state is ErrorInvoiceState) {
              return Center(child: MessageScreen(text: state.error));
            }
            if (state is LoadedInvoiceState) {
              return DefaultTabController(
                length: 3,
                child: _pageBody(state),
              );
            }
            return Center(child: Loaders.loading());
          },
          listener: (context, state) {},
        ),
      ),
    );
  }

  Widget _pageBody(LoadedInvoiceState state) {
    bool isSavedInvoice =
        state.invoice.status == Status.saved.name ? true : false;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.borderRadius),
          color:
              _getBackgroundColor(state.invoice.invoiceType).withOpacity(0.1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InvoiceToolBar(
            invoice: state.invoice,
            onSaveAsDraft: isSavedInvoice ? () {} : null,
            onSaveAsSaved: isSavedInvoice ? null : () {},
          ),
          TabBar(
            labelColor: AppColors.black,
            indicatorColor: AppColors.primaryColor,
            tabs: [
              Tab(text: 'invoice'.tr),
              Tab(text: 'options'.tr),
              Tab(text: 'print'.tr),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: TabBarView(children: [
              _invoiceTabWidgets(state, isSavedInvoice),
              InvoiceOptionsPage(enableEditing: !isSavedInvoice),
              const InvoicePrintPage()
            ]),
          ),
        ],
      ),
    );
  }

  Column _invoiceTabWidgets(LoadedInvoiceState state, bool isSavedInvoice) {
    return Column(
      children: [
        CustomInvoiceFields(enable: !isSavedInvoice),
        CustomInvoicePlutoTable(
          invoice: state.invoice,
          readOnly: isSavedInvoice,
        ),
      ],
    );
  }
}
