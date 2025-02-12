import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/bloc/invoice_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/cubit/invoice_form_cubit.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/pages/create_invoice_page.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/pages/invoice_options_page.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/pages/invoice_print_page.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoice_fields.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoice_page_container.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoice_pluto_table.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/invoice_tool_bar.dart';

class InvoicePage extends StatefulWidget {
  final String type;
  const InvoicePage({super.key, required this.type});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  late final InvoiceBloc _invoiceBloc;
  late final InvoiceFormCubit _invoiceFormCubit;

  @override
  void initState() {
    _invoiceBloc = sl<InvoiceBloc>()
      ..add(ShowInvoiceEvent(invoiceId: 1, type: widget.type))
      ..add(GetAccountsNameEvent());
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
    _invoiceBloc.add(UpdateInvoiceEvent(
        invoice: _invoiceFormCubit.invoiceEntity(Status.draft)));
  }

  void onSaveAsSaved() {
    _invoiceBloc.add(UpdateInvoiceEvent(
        invoice: _invoiceFormCubit.invoiceEntity(Status.saved)));
  }

  void onAdd() {
    context.read<TabCubit>().removeLastTab();
    context
        .read<TabCubit>()
        .addNewTab(title: 'new', content: CreateInvoicePage(type: widget.type));
  }

  void onRefresh() {
    context.read<InvoiceBloc>().add(ShowInvoiceEvent(
        invoiceId: _invoiceBloc.getInvoiceEntity.id!, type: widget.type));
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
      ],
      child: BlocBuilder<InvoiceBloc, InvoiceState>(
        builder: (context, state) {
          if (state is ErrorInvoiceState) {
            return Center(
              child: MessageScreen(
                text: state.error,
                onAdd: onAdd,
              ),
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
    bool isSavedInvoice =
        _invoiceBloc.getInvoiceEntity.status == Status.saved.name
            ? true
            : false;
    return CustomInvoicePageContainer(
      type: _invoiceBloc.getInvoiceEntity.invoiceType!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InvoiceToolBar(
            invoice: _invoiceBloc.getInvoiceEntity,
            onSaveAsDraft: isSavedInvoice ? onSaveAsDraft : null,
            onSaveAsSaved: isSavedInvoice ? null : onSaveAsSaved,
            onAdd: onAdd,
            onRefresh: onRefresh,
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
              _invoiceTabWidgets(isSavedInvoice),
              _invoiceOptionPage(isSavedInvoice),
              const InvoicePrintPage()
            ]),
          ),
        ],
      ),
    );
  }

  InvoiceOptionsPage _invoiceOptionPage(bool isSavedInvoice) {
    return InvoiceOptionsPage(
      enableEditing: !isSavedInvoice,
      goodsAccountController: _invoiceFormCubit.goodsAccountController,
      goodsAccountDescriptionController:
          _invoiceFormCubit.goodsAccountDescriptionController,
      taxAccountController: _invoiceFormCubit.taxAccountController,
      taxAmountController: _invoiceFormCubit.taxAmountController,
      taxAccountDescriptionController:
          _invoiceFormCubit.taxAccountDescriptionController,
      discountAccountController: _invoiceFormCubit.discountAccountController,
      discountAmountController: _invoiceFormCubit.discountAmountController,
      discountAccountDescriptionController:
          _invoiceFormCubit.discountAccountDescriptionController,
      errors: _invoiceBloc.getValidationErrors,
    );
  }

  Widget _invoiceTabWidgets(bool isSavedInvoice) {
    return ListView(
      children: [
        CustomInvoiceFields(
          enable: !isSavedInvoice,
          accountController: _invoiceFormCubit.accountController,
          dateController: _invoiceFormCubit.dateController,
          dueDateController: _invoiceFormCubit.dueDateController,
          addressController: _invoiceFormCubit.addressController,
          goodsAccountController: _invoiceFormCubit.goodsAccountController,
          notesController: _invoiceFormCubit.notesController,
          numberController: _invoiceFormCubit.numberController,
          errors: _invoiceBloc.getValidationErrors,
        ),
        _statusHint(),
        CustomInvoicePlutoTable(
          invoice: _invoiceBloc.getInvoiceEntity,
          readOnly: isSavedInvoice,
        ),
        _buildCustomFooter(context)
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
