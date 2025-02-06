import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/bloc/invoice_bloc.dart';
import 'package:ngu_app/features/inventory/invoices/presentation/pages/create_invoice_page.dart';

class InvoiceToolBar extends StatelessWidget {
  final InvoiceEntity? invoice;
  void Function()? onSaveAsDraft;
  void Function()? onSaveAsSaved;
  InvoiceToolBar(
      {super.key, this.onSaveAsDraft, this.onSaveAsSaved, this.invoice});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Visibility(
        visible: true,
        replacement: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconButton(
                icon: Icons.close, tooltip: 'close'.tr, onPressed: () {}),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navigateActions(context),
            _crudActions(context),
          ],
        ),
      ),
    );
  }

  Wrap _crudActions(BuildContext context) {
    return Wrap(
      children: [
        CustomIconButton(
          icon: Icons.add,
          tooltip: 'add'.tr,
          onPressed: () {
            context.read<TabCubit>().addNewTab(
                title: 'new',
                content: CreateInvoicePage(
                    type: context
                        .read<InvoiceBloc>()
                        .getInvoiceEntity
                        .invoiceType!));
          },
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
          onPressed: () {},
        ),
        CustomIconButton(
          icon: Icons.receipt,
          tooltip: 'receipt_print'.tr,
          onPressed: () {},
        ),
        CustomIconButton(
          icon: Icons.refresh,
          tooltip: 'refresh'.tr,
          onPressed: () => _navigate(context, invoice!.id, null),
        ),
      ],
    );
  }

  Wrap _navigateActions(BuildContext context) {
    return Wrap(
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
    );
  }

  void _navigate(BuildContext context, int? invoiceId, String? direction) {
    context.read<InvoiceBloc>().add(ShowInvoiceEvent(
        invoiceId: invoiceId ?? 1,
        direction: direction,
        type: invoice!.invoiceType!));
  }
}
