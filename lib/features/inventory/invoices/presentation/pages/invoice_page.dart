import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_account_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/bloc/invoice_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/pages/invoice_options_page.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/pages/invoice_print_page.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/widgets/custom_invoice_fields.dart';
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

  late TextEditingController _numberController;
  late TextEditingController _dateController;
  late TextEditingController _dueDateController;
  late TextEditingController _notesController;
  late InvoiceAccountEntity _accountController;

  late InvoiceAccountEntity _goodsAccountController;
  late TextEditingController _goodsAccountDescriptionController;

  late InvoiceAccountEntity _taxAccountController;
  late TextEditingController _taxAmountController;
  late TextEditingController _taxAccountDescriptionController;

  late InvoiceAccountEntity _discountAccountController;
  late TextEditingController _discountAmountController;
  late TextEditingController _discountAccountDescriptionController;

  @override
  void initState() {
    _invoiceBloc = sl<InvoiceBloc>()
      ..add(ShowInvoiceEvent(invoiceId: 1, type: widget.type))
      ..add(GetAccountsNameEvent());

    super.initState();
  }

  _initControllers(InvoiceEntity invoice) {
    _numberController =
        TextEditingController(text: invoice.invoiceNumber.toString());
    _dateController = TextEditingController(text: invoice.date);
    _dueDateController = TextEditingController(text: invoice.dueDate);
    _notesController = TextEditingController(text: invoice.notes);
    _accountController = invoice.account!;
    _invoiceBloc.natureController = invoice.invoiceNature;

    _goodsAccountController = invoice.goodsAccount!;
    _goodsAccountDescriptionController = TextEditingController();

    _taxAccountController = invoice.taxAccount!;
    _taxAccountDescriptionController = TextEditingController();
    _taxAmountController =
        TextEditingController(text: invoice.totalTax.toString());

    _discountAccountController = invoice.discountAccount!;
    _discountAmountController =
        TextEditingController(text: invoice.totalDiscount.toString());
    _discountAccountDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _invoiceBloc.close();
    _dateController.dispose();
    _dueDateController.dispose();
    _notesController.dispose();
    _numberController.dispose();

    super.dispose();
  }

  InvoiceEntity invoiceEntity(Enum status) {
    return InvoiceEntity(
      id: _invoiceBloc.getInvoiceEntity.id,
      invoiceNumber: int.parse(_numberController.text),
      invoiceType: widget.type,
      date: _dateController.text,
      dueDate: _dueDateController.text,
      status: status.name,
      invoiceNature: _invoiceBloc.natureController,
      notes: _notesController.text,
      account: _accountController,
      goodsAccount: _goodsAccountController,
      taxAccount: _taxAccountController,
      totalTax: double.tryParse(_taxAmountController.text) ?? 5,
      discountAccount: _discountAccountController,
      totalDiscount: double.tryParse(_taxAmountController.text) ?? 0,
    );
  }

  void _onSaveAsDraft() {
    _invoiceBloc.add(UpdateInvoiceEvent(invoice: invoiceEntity(Status.draft)));
  }

  void _onSaveAsSaved() {
    _invoiceBloc.add(UpdateInvoiceEvent(invoice: invoiceEntity(Status.saved)));
  }

  Color _getBackgroundColor(String type) {
    if (InvoiceType.purchase.name == type) {
      return Colors.green;
    }
    if (InvoiceType.sales.name == type) {
      return Colors.blue;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _invoiceBloc,
      child: BlocBuilder<InvoiceBloc, InvoiceState>(
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

  Widget _pageBody() {
    bool isSavedInvoice =
        _invoiceBloc.getInvoiceEntity.status == Status.saved.name
            ? true
            : false;
    return Container(
      padding: const EdgeInsets.only(
          right: Dimensions.primaryPadding, left: Dimensions.primaryPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.borderRadius),
        color: _getBackgroundColor(_invoiceBloc.getInvoiceEntity.invoiceType!)
            .withOpacity(0.05),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InvoiceToolBar(
            invoice: _invoiceBloc.getInvoiceEntity,
            onSaveAsDraft: isSavedInvoice ? _onSaveAsDraft : null,
            onSaveAsSaved: isSavedInvoice ? null : _onSaveAsSaved,
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
      goodsAccountController: _goodsAccountController,
      goodsAccountDescriptionController: _goodsAccountDescriptionController,
      taxAccountController: _taxAccountController,
      taxAmountController: _taxAmountController,
      taxAccountDescriptionController: _taxAccountDescriptionController,
      discountAccountController: _discountAccountController,
      discountAmountController: _discountAmountController,
      discountAccountDescriptionController:
          _discountAccountDescriptionController,
      accountController: _accountController,
      errors: _invoiceBloc.getValidationErrors,
    );
  }

  Widget _invoiceTabWidgets(bool isSavedInvoice) {
    return ListView(
      children: [
        CustomInvoiceFields(
          enable: !isSavedInvoice,
          accountController: _accountController,
          dateController: _dateController,
          dueDateController: _dueDateController,
          goodsAccountController: _goodsAccountController,
          notesController: _notesController,
          numberController: _numberController,
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
