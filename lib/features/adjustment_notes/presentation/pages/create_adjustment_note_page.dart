import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_accordion.dart';
import 'package:ngu_app/core/widgets/custom_saved_tab.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/snack_bar.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_entity.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_bloc/adjustment_note_bloc.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_form_cubit/adjustment_note_form_cubit.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/preview_adjustment_note_item_cubit/preview_adjustment_note_item_cubit.dart';

import 'package:ngu_app/features/adjustment_notes/presentation/pages/adjustment_note_page.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/adjustment_note_tool_bar.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/custom_adjustment_note_fields.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/custom_adjustment_note_page_container.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/custom_adjustment_note_pluto_table.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';

class CreateAdjustmentNotePage extends StatefulWidget {
  final String type;
  const CreateAdjustmentNotePage({super.key, required this.type});

  @override
  State<CreateAdjustmentNotePage> createState() =>
      _CreateAdjustmentNotePageState();
}

class _CreateAdjustmentNotePageState extends State<CreateAdjustmentNotePage> {
  late final AdjustmentNoteBloc _adjustmentNoteBloc;

  late final AdjustmentNoteFormCubit _adjustmentNoteFormCubit;

  @override
  void initState() {
    _adjustmentNoteBloc = sl<AdjustmentNoteBloc>()
      ..add(GetCreateAdjustmentNoteFormData(type: widget.type));

    _adjustmentNoteFormCubit = AdjustmentNoteFormCubit(
        adjustmentNoteBloc: _adjustmentNoteBloc,
        adjustmentNoteType: widget.type);

    super.initState();
  }

  _initControllers(AdjustmentNoteEntity adjustmentNote) {
    _adjustmentNoteFormCubit.initControllers(adjustmentNote);
  }

  @override
  void dispose() {
    _adjustmentNoteBloc.close();
    _adjustmentNoteFormCubit.disposeControllers();

    super.dispose();
  }

  void onSaveAsDraft() {
    if (_adjustmentNoteFormCubit.validateForm()) {
      _adjustmentNoteBloc.add(CreateAdjustmentNoteEvent(
          adjustmentNote:
              _adjustmentNoteFormCubit.adjustmentNoteEntity(Status.draft)));
    } else {
      ShowSnackBar.showValidationSnackbar(messages: ['required'.tr]);
    }
  }

  void onSaveAsSaved() {
    if (_adjustmentNoteFormCubit.validateForm()) {
      _adjustmentNoteBloc.add(CreateAdjustmentNoteEvent(
          adjustmentNote:
              _adjustmentNoteFormCubit.adjustmentNoteEntity(Status.saved)));
    } else {
      ShowSnackBar.showValidationSnackbar(messages: ['required'.tr]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _adjustmentNoteBloc,
        ),
        BlocProvider(
          create: (context) => _adjustmentNoteFormCubit,
        ),
        BlocProvider(
          create: (context) => sl<PreviewAdjustmentNoteItemCubit>(),
        ),
      ],
      child: BlocConsumer<AdjustmentNoteBloc, AdjustmentNoteState>(
        listener: (context, state) {
          if (state is CreatedAdjustmentNoteState) {
            context.read<TabCubit>().removeCurrentTab();
            context.read<TabCubit>().addNewTab(
                title: widget.type.tr,
                content: AdjustmentNotePage(
                  type: widget.type,
                  adjustmentNoteId:
                      _adjustmentNoteBloc.getAdjustmentNoteEntity.id!,
                ));
          }
        },
        builder: (context, state) {
          if (state is ErrorAdjustmentNoteState) {
            return Center(child: MessageScreen(text: state.error));
          }
          if (state is LoadedAdjustmentNoteState) {
            _initControllers(_adjustmentNoteBloc.getAdjustmentNoteEntity);
            return _pageBody();
          }
          return Center(child: Loaders.loading());
        },
      ),
    );
  }

  void onAdjustmentNoteSearch() {
    context.read<TabCubit>().addNewTab(
        title: widget.type.tr,
        content: AdjustmentNotePage(
            type: widget.type,
            adjustmentNoteId: int.parse(_adjustmentNoteFormCubit
                .adjustmentNoteSearchNumController.text)));
  }

  Widget _pageBody() {
    return CustomAdjustmentNotePageContainer(
      type: _adjustmentNoteBloc.getAdjustmentNoteEntity.adjustmentNoteType!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AdjustmentNoteToolBar(
            onSaveAsDraft: onSaveAsDraft,
            onSaveAsSaved: onSaveAsSaved,
            adjustmentNoteType: widget.type,
            onAdjustmentNoteSearch: onAdjustmentNoteSearch,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _adjustmentNoteTabWidgets(false),
          ),
        ],
      ),
    );
  }

  Widget _adjustmentNoteTabWidgets(bool isSavedAdjustmentNote) {
    return CustomSavedTab(
      child: ListView(
        children: [
          CustomAdjustmentNoteFields(
            enableEditing: !isSavedAdjustmentNote,
            adjustmentNoteBloc: _adjustmentNoteBloc,
            adjustmentNoteFormCubit: _adjustmentNoteFormCubit,
            errors: _adjustmentNoteBloc.getValidationErrors,
          ),
          CustomAccordion(
            icon: Icons.table_chart_outlined,
            isOpen: false,
            title: 'inventory'.tr,
            contentWidget: CustomAdjustmentNotePlutoTable(
              readOnly: isSavedAdjustmentNote,
              adjustmentNote: _adjustmentNoteBloc.getAdjustmentNoteEntity,
            ),
          ),
        ],
      ),
    );
  }
}
