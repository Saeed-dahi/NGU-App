import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/home/presentation/cubit/tab_cubit.dart';

import 'package:ngu_app/features/journals/presentation/bloc/journal_bloc.dart';
import 'package:ngu_app/features/journals/presentation/pages/create_journal.dart';

class JournalVouchersToolBar extends StatelessWidget {
  final int? journalId;
  void Function()? onSaveAsDraft;
  void Function()? onSaveAsSaved;
  JournalVouchersToolBar(
      {super.key, this.journalId, this.onSaveAsDraft, this.onSaveAsSaved});

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
            Visibility(
              visible: journalId != null,
              child: SizedBox(
                  width: 100,
                  child: CustomInputField(
                    inputType: TextInputType.number,
                    label: journalId.toString(),
                    autofocus: false,
                    isCenterLabel: true,
                    onChanged: (value) {
                      int journalId = int.parse(value);
                      context
                          .read<JournalBloc>()
                          .add(ShowJournalEvent(journalId: journalId));
                    },
                  )),
            ),
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
                title: '${'add'.tr} ${'journal_voucher'.tr}',
                content: const CreateJournal());
          },
        ),
        CustomIconButton(
            icon: Icons.check_outlined,
            tooltip: 'post'.tr,
            onPressed: onSaveAsSaved),
        CustomIconButton(
            icon: Icons.save, tooltip: 'save'.tr, onPressed: onSaveAsDraft),
        CustomIconButton(
          icon: Icons.print,
          tooltip: 'print'.tr,
          onPressed: () {},
        ),
        CustomIconButton(
          icon: Icons.insert_drive_file_outlined,
          tooltip: '${'insert'.tr} ${'row'.tr}',
          onPressed: () {
            context.read<JournalBloc>().getStateManger.appendNewRows(count: 1);
          },
        ),
        CustomIconButton(
          icon: Icons.delete_forever,
          tooltip: '${'delete'.tr} ${'row'.tr}',
          onPressed: () {
            context.read<JournalBloc>().getStateManger.removeCurrentRow();
          },
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
            onPressed: () {
              _navigate(context, journalId, 'first');
            }),
        CustomIconButton(
            icon: Icons.arrow_left_rounded,
            tooltip: 'previous'.tr,
            onPressed: () {
              _navigate(context, journalId, 'previous');
            }),
        CustomIconButton(
            icon: Icons.arrow_right_rounded,
            tooltip: 'next'.tr,
            onPressed: () {
              _navigate(context, journalId, 'next');
            }),
        CustomIconButton(
            icon: Icons.fast_forward_rounded,
            tooltip: 'last'.tr,
            onPressed: () {
              _navigate(context, journalId, 'last');
            }),
      ],
    );
  }

  void _navigate(BuildContext context, int? journalId, String direction) {
    if (journalId != null) {
      context.read<JournalBloc>().add(
            ShowJournalEvent(
              journalId: journalId,
              direction: direction,
            ),
          );
    }
  }
}
