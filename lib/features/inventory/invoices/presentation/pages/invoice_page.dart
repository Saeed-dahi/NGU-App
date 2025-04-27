import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/features/printing/presentation/bloc/printing_bloc.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/snack_bar.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_bloc/invoice_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_form_cubit/invoice_form_cubit.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/preview_invoice_item_cubit/preview_invoice_item_cubit.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/pages/create_invoice_page.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/pages/invoice_options_page.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/pages/printing/invoice_print_page_settings.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoice_fields.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoice_page_container.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoice_pluto_table.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/invoice_tool_bar.dart';

class InvoicePage extends StatefulWidget {
  final String type;
  final int invoiceId;
  const InvoicePage({super.key, required this.type, this.invoiceId = 1});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  late final InvoiceBloc _invoiceBloc;
  late final InvoiceFormCubit _invoiceFormCubit;

  @override
  void initState() {
    _invoiceBloc = sl<InvoiceBloc>()
      ..add(
          ShowInvoiceEvent(invoiceQuery: widget.invoiceId, type: widget.type));
    _invoiceFormCubit =
        InvoiceFormCubit(invoiceBloc: _invoiceBloc, invoiceType: widget.type);

    super.initState();
  }

  _initControllers(InvoiceEntity invoice) {
    _invoiceFormCubit.initControllers(invoice);
    _invoiceBloc.isSavedInvoice =
        invoice.status == Status.saved.name ? true : false;
  }

  @override
  void dispose() {
    _invoiceBloc.close();
    _invoiceFormCubit.disposeControllers();
    super.dispose();
  }

  void onSaveAsDraft() {
    _invoiceBloc.add(UpdateInvoiceEvent(
        invoice: _invoiceFormCubit.invoiceEntity(Status.draft)));
  }

  void onSaveAsSaved() {
    if (_invoiceFormCubit.validateForm()) {
      _invoiceBloc.add(UpdateInvoiceEvent(
          invoice: _invoiceFormCubit.invoiceEntity(Status.saved)));
    } else {
      ShowSnackBar.showValidationSnackbar(messages: ['required'.tr]);
    }
  }

  void onAdd() {
    context.read<TabCubit>().removeCurrentTab();
    context.read<TabCubit>().addNewTab(
        title: '${widget.type.tr} (${'new'.tr})',
        content: CreateInvoicePage(type: widget.type));
  }

  void onRefresh() {
    _invoiceBloc.add(ShowInvoiceEvent(
        invoiceQuery: _invoiceBloc.getInvoiceEntity.id!, type: widget.type));
  }

  void onInvoiceSearch() {
    _invoiceBloc.add(
      ShowInvoiceEvent(
        invoiceQuery:
            int.parse(_invoiceFormCubit.invoiceSearchNumController.text),
        getBy: 'invoice_number',
        type: widget.type,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _invoiceBloc,
        ),
        BlocProvider(
          create: (context) => _invoiceFormCubit,
        ),
        BlocProvider(
          create: (context) => sl<PreviewInvoiceItemCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<PrintingBloc>()
            ..add(GetPrinterEvent(printerType: PrinterType.receipt.name))
            ..add(GetPrinterEvent(printerType: PrinterType.tax_invoice.name)),
          lazy: false,
        ),
      ],
      child: BlocBuilder<InvoiceBloc, InvoiceState>(
        builder: (context, state) {
          if (state is ErrorInvoiceState) {
            return Column(
              children: [
                InvoiceToolBar(
                  onAdd: onAdd,
                  invoiceType: widget.type,
                  onInvoiceSearch: onInvoiceSearch,
                ),
                Center(
                  child: MessageScreen(
                    text: state.error,
                  ),
                ),
              ],
            );
          }

          if (state is LoadedInvoiceState) {
            _initControllers(_invoiceBloc.getInvoiceEntity);
            return DefaultTabController(
              length: 3,
              child: _pageBody(),
            );
          }
          return Center(child: Loaders.loading());
        },
      ),
    );
  }

  Widget _pageBody() {
    return CustomInvoicePageContainer(
      type: _invoiceBloc.getInvoiceEntity.invoiceType!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InvoiceToolBar(
            invoice: _invoiceBloc.getInvoiceEntity,
            onSaveAsDraft: _invoiceBloc.isSavedInvoice ? onSaveAsDraft : null,
            onSaveAsSaved: _invoiceBloc.isSavedInvoice ? null : onSaveAsSaved,
            onAdd: onAdd,
            onRefresh: onRefresh,
            invoiceType: widget.type,
            onInvoiceSearch: onInvoiceSearch,
          ),
          TabBar(
            labelColor: AppColors.black,
            indicatorColor: AppColors.primaryColor,
            tabs: [
              Tab(text: '${'invoice'.tr} ${widget.type.tr}'),
              Tab(text: 'options'.tr),
              Tab(text: 'print'.tr),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: TabBarView(children: [
              _invoiceTabWidgets(_invoiceBloc.isSavedInvoice),
              _invoiceOptionPage(_invoiceBloc.isSavedInvoice),
              const InvoicePrintPageSettings()
            ]),
          ),
        ],
      ),
    );
  }

  InvoiceOptionsPage _invoiceOptionPage(bool isSavedInvoice) {
    return InvoiceOptionsPage(
      enableEditing: !isSavedInvoice,
      invoiceBloc: _invoiceBloc,
      invoiceFormCubit: _invoiceFormCubit,
      errors: _invoiceBloc.getValidationErrors,
    );
  }

  Widget _invoiceTabWidgets(bool isSavedInvoice) {
    return ListView(
      children: [
        CustomInvoiceFields(
          enable: !isSavedInvoice,
          invoiceBloc: _invoiceBloc,
          invoiceFormCubit: _invoiceFormCubit,
          errors: _invoiceBloc.getValidationErrors,
        ),
        _statusHint(),
        CustomInvoicePlutoTable(
          invoice: _invoiceBloc.getInvoiceEntity,
          readOnly: isSavedInvoice,
        ),
      ],
    );
  }

  Visibility _statusHint() {
    return Visibility(
      visible: _invoiceBloc.getInvoiceEntity.status == Status.saved.name,
      replacement: Text(
        'draft'.tr,
        style: const TextStyle(
          color: AppColors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(
        'saved'.tr,
        style: const TextStyle(
          color: AppColors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCustomFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${'tax_amount'.tr} (${_invoiceBloc.getInvoiceEntity.totalTax}%): ${(_invoiceBloc.getInvoiceEntity.subTotal! * _invoiceBloc.getInvoiceEntity.totalTax! / 100).toString()}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            '${'total'.tr}: ${(_invoiceBloc.getInvoiceEntity.total).toString()}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
