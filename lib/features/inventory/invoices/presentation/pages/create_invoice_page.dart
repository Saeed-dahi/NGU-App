import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/features/printing/presentation/bloc/printing_bloc.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_saved_tab.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/snack_bar.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_bloc/invoice_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_form_cubit/invoice_form_cubit.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/preview_invoice_item_cubit/preview_invoice_item_cubit.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/pages/invoice_options_page.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/pages/invoice_page.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/pages/printing/invoice_print_page_settings.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoice_fields.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoice_footer.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoice_page_container.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoice_pluto_table.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/invoice_tool_bar.dart';

class CreateInvoicePage extends StatefulWidget {
  final String type;
  const CreateInvoicePage({super.key, required this.type});

  @override
  State<CreateInvoicePage> createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage> {
  late final InvoiceBloc _invoiceBloc;

  late final InvoiceFormCubit _invoiceFormCubit;

  @override
  void initState() {
    _invoiceBloc = sl<InvoiceBloc>()
      ..add(GetCreateInvoiceFormData(type: widget.type));

    _invoiceFormCubit =
        InvoiceFormCubit(invoiceBloc: _invoiceBloc, invoiceType: widget.type);

    super.initState();
  }

  _initControllers(InvoiceEntity invoice) {
    _invoiceFormCubit.initControllers(invoice);
  }

  @override
  void dispose() {
    _invoiceBloc.close();
    _invoiceFormCubit.disposeControllers();

    super.dispose();
  }

  void onSaveAsDraft() {
    if (_invoiceFormCubit.validateForm()) {
      _invoiceBloc.add(CreateInvoiceEvent(
          invoice: _invoiceFormCubit.invoiceEntity(Status.draft)));
    } else {
      ShowSnackBar.showValidationSnackbar(messages: ['required'.tr]);
    }
  }

  void onSaveAsSaved() {
    if (_invoiceFormCubit.validateForm()) {
      _invoiceBloc.add(CreateInvoiceEvent(
          invoice: _invoiceFormCubit.invoiceEntity(Status.saved)));
    } else {
      ShowSnackBar.showValidationSnackbar(messages: ['required'.tr]);
    }
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
      child: BlocConsumer<InvoiceBloc, InvoiceState>(
        listener: (context, state) {
          if (state is CreatedInvoiceState) {
            context.read<TabCubit>().removeCurrentTab();
            context.read<TabCubit>().addNewTab(
                title: widget.type.tr,
                content: InvoicePage(
                  type: widget.type,
                  invoiceId: _invoiceBloc.getInvoiceEntity.id!,
                ));
          }
        },
        builder: (context, state) {
          if (state is ErrorInvoiceState) {
            return Center(child: MessageScreen(text: state.error));
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

  void onInvoiceSearch() {
    context.read<TabCubit>().addNewTab(
        title: widget.type.tr,
        content: InvoicePage(
            type: widget.type,
            invoiceId:
                int.parse(_invoiceFormCubit.invoiceSearchNumController.text)));
  }

  Widget _pageBody() {
    return CustomInvoicePageContainer(
      type: _invoiceBloc.getInvoiceEntity.invoiceType!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InvoiceToolBar(
            // invoice: _invoiceBloc.getInvoiceEntity,
            onSaveAsDraft: onSaveAsDraft,
            onSaveAsSaved: onSaveAsSaved,
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
              _invoiceTabWidgets(false),
              _invoiceOptionPage(false),
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
    return CustomSavedTab(
      child: ListView(
        children: [
          CustomInvoiceFields(
            enable: !isSavedInvoice,
            invoiceBloc: _invoiceBloc,
            invoiceFormCubit: _invoiceFormCubit,
            errors: _invoiceBloc.getValidationErrors,
          ),
          CustomInvoicePlutoTable(
            readOnly: isSavedInvoice,
            invoice: _invoiceBloc.getInvoiceEntity,
          ),
          CustomInvoiceFooter(
            invoiceFormCubit: _invoiceFormCubit,
            invoiceBloc: _invoiceBloc,
            enableEditing: true,
          ),
        ],
      ),
    );
  }
}
