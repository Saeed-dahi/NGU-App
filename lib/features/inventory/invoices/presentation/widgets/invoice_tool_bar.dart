import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_editable_text.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';

import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_bloc/invoice_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/blocs/invoice_form_cubit/invoice_form_cubit.dart';

class InvoiceToolBar extends StatelessWidget {
  final InvoiceEntity? invoice;
  final String? invoiceType;
  void Function()? onSaveAsDraft;
  void Function()? onSaveAsSaved;
  void Function()? onAdd;
  void Function()? onRefresh;
  void Function() onInvoiceSearch;
  InvoiceToolBar(
      {super.key,
      this.onSaveAsDraft,
      this.onSaveAsSaved,
      this.invoice,
      this.invoiceType,
      this.onAdd,
      this.onRefresh,
      required this.onInvoiceSearch});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navigateActions(context),
          CustomEditableText(
              controller:
                  context.read<InvoiceFormCubit>().invoiceSearchNumController,
              enable: true,
              width: 0.1,
              hint: 'Search',
              onEditingComplete: onInvoiceSearch),
          _crudActions(context),
        ],
      ),
    );
  }

  Widget _crudActions(BuildContext context) {
    return Wrap(
      children: [
        CustomIconButton(
          icon: Icons.add,
          tooltip: 'add'.tr,
          onPressed: onAdd,
        ),
        Visibility(
          visible: onSaveAsSaved != null,
          replacement: CustomIconButton(
              icon: Icons.unarchive,
              tooltip: 'un_post'.tr,
              onPressed: onSaveAsDraft),
          child: CustomIconButton(
              icon: Icons.check_outlined,
              tooltip: 'post'.tr,
              onPressed: onSaveAsSaved),
        ),
        Visibility(
          visible: onSaveAsDraft != null && onSaveAsSaved != null,
          child: CustomIconButton(
              icon: Icons.save, tooltip: 'save'.tr, onPressed: onSaveAsDraft),
        ),
        CustomIconButton(
          icon: Icons.print,
          tooltip: 'print'.tr,
          onPressed: () async {
            context.read<InvoiceBloc>().printTaxInvoice(context);
          },
        ),
        CustomIconButton(
          icon: Icons.receipt,
          tooltip: 'receipt_print'.tr,
          onPressed: () {
            context.read<InvoiceBloc>().printReceipt(context);
          },
        ),
        CustomIconButton(
          icon: Icons.refresh,
          tooltip: 'refresh'.tr,
          onPressed: onRefresh,
        ),
      ],
    );
  }

  Widget _navigateActions(BuildContext context) {
    return Visibility(
      visible: invoice != null,
      child: Wrap(
        children: [
          CustomIconButton(
            icon: Icons.fast_rewind_rounded,
            tooltip: 'first'.tr,
            onPressed: () => _navigate(context, invoice!.id, 'first'),
          ),
          CustomIconButton(
            icon: Icons.arrow_left_rounded,
            tooltip: 'previous'.tr,
            onPressed: () => _navigate(context, invoice!.id, 'previous'),
          ),
          CustomIconButton(
            icon: Icons.arrow_right_rounded,
            tooltip: 'next'.tr,
            onPressed: () => _navigate(context, invoice!.id, 'next'),
          ),
          CustomIconButton(
            icon: Icons.fast_forward_rounded,
            tooltip: 'last'.tr,
            onPressed: () => _navigate(context, invoice!.id, 'last'),
          ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, int? invoiceId, String? direction) {
    context.read<InvoiceBloc>().add(ShowInvoiceEvent(
        invoiceQuery: invoiceId ?? 1,
        direction: direction,
        type: invoice!.invoiceType!));
  }
}
