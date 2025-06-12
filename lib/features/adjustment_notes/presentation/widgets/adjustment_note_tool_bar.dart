import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/widgets/custom_editable_text.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_entity.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_bloc/adjustment_note_bloc.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_form_cubit/adjustment_note_form_cubit.dart';

class AdjustmentNoteToolBar extends StatelessWidget {
  final AdjustmentNoteEntity? adjustmentNote;
  final String? adjustmentNoteType;
  void Function()? onSaveAsDraft;
  void Function()? onSaveAsSaved;
  void Function()? onAdd;
  void Function()? onRefresh;
  void Function() onAdjustmentNoteSearch;
  AdjustmentNoteToolBar(
      {super.key,
      this.onSaveAsDraft,
      this.onSaveAsSaved,
      this.adjustmentNote,
      this.adjustmentNoteType,
      this.onAdd,
      this.onRefresh,
      required this.onAdjustmentNoteSearch});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navigateActions(context),
          CustomEditableText(
              controller: context
                  .read<AdjustmentNoteFormCubit>()
                  .invoiceSearchNumController,
              enable: true,
              width: 0.1,
              hint: 'search'.tr,
              onEditingComplete: onAdjustmentNoteSearch),
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
          onPressed: () async {},
        ),
        CustomIconButton(
          icon: Icons.receipt,
          tooltip: 'receipt_print'.tr,
          onPressed: () {},
        ),
        CustomIconButton(
          icon: Icons.import_export,
          tooltip: 'export'.tr,
          onPressed: () {},
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
      visible: adjustmentNote != null,
      child: Wrap(
        children: [
          CustomIconButton(
            icon: Icons.fast_rewind_rounded,
            tooltip: 'first'.tr,
            onPressed: () => _navigate(context, adjustmentNote!.id, 'first'),
          ),
          CustomIconButton(
            icon: Icons.arrow_left_rounded,
            tooltip: 'previous'.tr,
            onPressed: () => _navigate(context, adjustmentNote!.id, 'previous'),
          ),
          CustomIconButton(
            icon: Icons.arrow_right_rounded,
            tooltip: 'next'.tr,
            onPressed: () => _navigate(context, adjustmentNote!.id, 'next'),
          ),
          CustomIconButton(
            icon: Icons.fast_forward_rounded,
            tooltip: 'last'.tr,
            onPressed: () => _navigate(context, adjustmentNote!.id, 'last'),
          ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, int? invoiceId, String? direction) {
    context.read<AdjustmentNoteBloc>().add(ShowAdjustmentNoteEvent(
        adjustmentNoteQuery: invoiceId ?? 1,
        direction: direction,
        type: adjustmentNote!.invoiceType!));
  }
}
