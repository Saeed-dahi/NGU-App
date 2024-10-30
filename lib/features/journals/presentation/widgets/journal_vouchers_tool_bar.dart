import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';
import 'package:ngu_app/features/journals/presentation/bloc/journal_bloc.dart';

class JournalVouchersToolBar extends StatelessWidget {
  final JournalEntity journalEntity;
  const JournalVouchersToolBar({super.key, required this.journalEntity});

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
            SizedBox(
                width: 100,
                child: CustomInputField(
                  inputType: TextInputType.number,
                  label: journalEntity.id.toString(),
                  autofocus: false,
                  isCenterLabel: true,
                  onChanged: (value) {
                    int journalId = int.parse(value);
                    context
                        .read<JournalBloc>()
                        .add(ShowJournalEvent(journalId: journalId));
                  },
                )),
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
          onPressed: () {},
        ),
        CustomIconButton(
            icon: Icons.check_outlined, tooltip: 'post'.tr, onPressed: () {}),
        CustomIconButton(
            icon: Icons.save, tooltip: 'save'.tr, onPressed: () {}),
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
              _navigate(context, journalEntity.id, 'first');
            }),
        CustomIconButton(
            icon: Icons.arrow_left_rounded,
            tooltip: 'previous'.tr,
            onPressed: () {
              _navigate(context, journalEntity.id, 'previous');
            }),
        CustomIconButton(
            icon: Icons.arrow_right_rounded,
            tooltip: 'next'.tr,
            onPressed: () {
              _navigate(context, journalEntity.id, 'next');
            }),
        CustomIconButton(
            icon: Icons.fast_forward_rounded,
            tooltip: 'last'.tr,
            onPressed: () {
              _navigate(context, journalEntity.id, 'last');
            }),
      ],
    );
  }

  void _navigate(BuildContext context, int journalId, String direction) {
    return context.read<JournalBloc>().add(
          ShowJournalEvent(
            journalId: journalId,
            direction: direction,
          ),
        );
  }
}
