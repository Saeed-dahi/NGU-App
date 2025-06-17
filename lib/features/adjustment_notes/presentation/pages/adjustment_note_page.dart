import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
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
import 'package:ngu_app/features/adjustment_notes/presentation/pages/create_adjustment_note_page.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/adjustment_note_tool_bar.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/custom_adjustment_note_fields.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/custom_adjustment_note_page_container.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/custom_adjustment_note_pluto_table.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';

class AdjustmentNotePage extends StatefulWidget {
  final String type;
  final int adjustmentNoteId;
  const AdjustmentNotePage(
      {super.key, required this.type, this.adjustmentNoteId = 1});

  @override
  State<AdjustmentNotePage> createState() => _AdjustmentNotePageState();
}

class _AdjustmentNotePageState extends State<AdjustmentNotePage> {
  late final AdjustmentNoteBloc _adjustmentNoteBloc;
  late final AdjustmentNoteFormCubit _adjustmentNoteFormCubit;

  @override
  void initState() {
    _adjustmentNoteBloc = sl<AdjustmentNoteBloc>()
      ..add(ShowAdjustmentNoteEvent(
          adjustmentNoteQuery: widget.adjustmentNoteId, type: widget.type));
    _adjustmentNoteFormCubit = AdjustmentNoteFormCubit(
        adjustmentNoteBloc: _adjustmentNoteBloc,
        adjustmentNoteType: widget.type);

    super.initState();
  }

  _initControllers(AdjustmentNoteEntity adjustmentNote) {
    _adjustmentNoteFormCubit.initControllers(adjustmentNote);
    _adjustmentNoteBloc.isSavedAdjustmentNote =
        adjustmentNote.status == Status.saved.name ? true : false;
  }

  @override
  void dispose() {
    _adjustmentNoteBloc.close();
    _adjustmentNoteFormCubit.disposeControllers();
    super.dispose();
  }

  void onSaveAsDraft() {
    _adjustmentNoteBloc.add(UpdateAdjustmentNoteEvent(
        adjustmentNote:
            _adjustmentNoteFormCubit.adjustmentNoteEntity(Status.draft)));
  }

  void onSaveAsSaved() {
    if (_adjustmentNoteFormCubit.validateForm()) {
      _adjustmentNoteBloc.add(UpdateAdjustmentNoteEvent(
          adjustmentNote:
              _adjustmentNoteFormCubit.adjustmentNoteEntity(Status.saved)));
    } else {
      ShowSnackBar.showValidationSnackbar(messages: ['required'.tr]);
    }
  }

  void onAdd() {
    context.read<TabCubit>().removeCurrentTab();
    context.read<TabCubit>().addNewTab(
        title: '${widget.type.tr} (${'new'.tr})',
        content: CreateAdjustmentNotePage(type: widget.type));
  }

  void onRefresh() {
    _adjustmentNoteBloc.add(ShowAdjustmentNoteEvent(
        adjustmentNoteQuery: _adjustmentNoteBloc.getAdjustmentNoteEntity.id!,
        type: widget.type));
  }

  void onAdjustmentNoteSearch() {
    _adjustmentNoteBloc.add(
      ShowAdjustmentNoteEvent(
        adjustmentNoteQuery: int.parse(
            _adjustmentNoteFormCubit.adjustmentNoteSearchNumController.text),
        getBy: 'adjustment_note_number',
        type: widget.type,
      ),
    );
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
      child: BlocBuilder<AdjustmentNoteBloc, AdjustmentNoteState>(
        builder: (context, state) {
          if (state is ErrorAdjustmentNoteState) {
            return Column(
              children: [
                AdjustmentNoteToolBar(
                  onAdd: onAdd,
                  adjustmentNoteType: widget.type,
                  onAdjustmentNoteSearch: onAdjustmentNoteSearch,
                ),
                Center(
                  child: MessageScreen(
                    text: state.error,
                  ),
                ),
              ],
            );
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

  Widget _pageBody() {
    return CustomAdjustmentNotePageContainer(
      type: _adjustmentNoteBloc.getAdjustmentNoteEntity.adjustmentNoteType!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AdjustmentNoteToolBar(
            adjustmentNote: _adjustmentNoteBloc.getAdjustmentNoteEntity,
            onSaveAsDraft: _adjustmentNoteBloc.isSavedAdjustmentNote
                ? onSaveAsDraft
                : null,
            onSaveAsSaved: _adjustmentNoteBloc.isSavedAdjustmentNote
                ? null
                : onSaveAsSaved,
            onAdd: onAdd,
            onRefresh: onRefresh,
            adjustmentNoteType: widget.type,
            onAdjustmentNoteSearch: onAdjustmentNoteSearch,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _adjustmentNoteTabWidgets(
                _adjustmentNoteBloc.isSavedAdjustmentNote),
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
          _statusHint(),
          CustomAccordion(
            icon: Icons.table_chart_outlined,
            isOpen: false,
            title: 'inventory'.tr,
            contentWidget: CustomAdjustmentNotePlutoTable(
              adjustmentNote: _adjustmentNoteBloc.getAdjustmentNoteEntity,
              readOnly: isSavedAdjustmentNote,
            ),
          ),
        ],
      ),
    );
  }

  Visibility _statusHint() {
    return Visibility(
      visible: _adjustmentNoteBloc.getAdjustmentNoteEntity.status ==
          Status.saved.name,
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
}
