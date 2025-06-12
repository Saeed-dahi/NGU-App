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
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_entity.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_bloc/adjustment_note_bloc.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_form_cubit/adjustment_note_form_cubit.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/preview_adjustment_note_item_cubit/preview_invoice_item_cubit.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/pages/adjustment_note_options_page.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/pages/create_adjustment_note_page.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/adjustment_note_tool_bar.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/custom_adjustment_note_fields.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/custom_adjustment_note_footer.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/custom_adjustment_note_page_container.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/custom_adjustment_note_pluto_table.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';

class AdjustmentNotePage extends StatefulWidget {
  final String type;
  final int invoiceId;
  const AdjustmentNotePage({super.key, required this.type, this.invoiceId = 1});

  @override
  State<AdjustmentNotePage> createState() => _AdjustmentNotePageState();
}

class _AdjustmentNotePageState extends State<AdjustmentNotePage> {
  late final AdjustmentNoteBloc _invoiceBloc;
  late final AdjustmentNoteFormCubit _invoiceFormCubit;

  @override
  void initState() {
    _invoiceBloc = sl<AdjustmentNoteBloc>()
      ..add(ShowAdjustmentNoteEvent(
          adjustmentNoteQuery: widget.invoiceId, type: widget.type));
    _invoiceFormCubit = AdjustmentNoteFormCubit(
        invoiceBloc: _invoiceBloc, invoiceType: widget.type);

    super.initState();
  }

  _initControllers(AdjustmentNoteEntity invoice) {
    _invoiceFormCubit.initControllers(invoice);
    _invoiceBloc.isSavedAdjustmentNote =
        invoice.status == Status.saved.name ? true : false;
  }

  @override
  void dispose() {
    _invoiceBloc.close();
    _invoiceFormCubit.disposeControllers();
    super.dispose();
  }

  void onSaveAsDraft() {
    _invoiceBloc.add(UpdateAdjustmentNoteEvent(
        adjustmentNote: _invoiceFormCubit.invoiceEntity(Status.draft)));
  }

  void onSaveAsSaved() {
    if (_invoiceFormCubit.validateForm()) {
      _invoiceBloc.add(UpdateAdjustmentNoteEvent(
          adjustmentNote: _invoiceFormCubit.invoiceEntity(Status.saved)));
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
    _invoiceBloc.add(ShowAdjustmentNoteEvent(
        adjustmentNoteQuery: _invoiceBloc.getAdjustmentNoteEntity.id!,
        type: widget.type));
  }

  void onAdjustmentNoteSearch() {
    _invoiceBloc.add(
      ShowAdjustmentNoteEvent(
        adjustmentNoteQuery:
            int.parse(_invoiceFormCubit.invoiceSearchNumController.text),
        getBy: 'invoice_number',
        type: widget.type,
      ),
    );
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
          create: (context) => sl<PreviewAdjustmentNoteItemCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<PrintingBloc>()
            ..add(GetPrinterEvent(printerType: PrinterType.receipt.name))
            ..add(GetPrinterEvent(printerType: PrinterType.tax_invoice.name)),
          lazy: false,
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
            _initControllers(_invoiceBloc.getAdjustmentNoteEntity);
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
    return CustomAdjustmentNotePageContainer(
      type: _invoiceBloc.getAdjustmentNoteEntity.invoiceType!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AdjustmentNoteToolBar(
            adjustmentNote: _invoiceBloc.getAdjustmentNoteEntity,
            onSaveAsDraft:
                _invoiceBloc.isSavedAdjustmentNote ? onSaveAsDraft : null,
            onSaveAsSaved:
                _invoiceBloc.isSavedAdjustmentNote ? null : onSaveAsSaved,
            onAdd: onAdd,
            onRefresh: onRefresh,
            adjustmentNoteType: widget.type,
            onAdjustmentNoteSearch: onAdjustmentNoteSearch,
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
              _invoiceTabWidgets(_invoiceBloc.isSavedAdjustmentNote),
              _invoiceOptionPage(_invoiceBloc.isSavedAdjustmentNote),
              const SizedBox()
            ]),
          ),
        ],
      ),
    );
  }

  AdjustmentNoteOptionsPage _invoiceOptionPage(bool isSavedAdjustmentNote) {
    return AdjustmentNoteOptionsPage(
      enableEditing: !isSavedAdjustmentNote,
      invoiceBloc: _invoiceBloc,
      invoiceFormCubit: _invoiceFormCubit,
      errors: _invoiceBloc.getValidationErrors,
    );
  }

  Widget _invoiceTabWidgets(bool isSavedAdjustmentNote) {
    return CustomSavedTab(
      child: ListView(
        children: [
          CustomAdjustmentNoteFields(
            enable: !isSavedAdjustmentNote,
            adjustmentNoteBloc: _invoiceBloc,
            adjustmentNoteFormCubit: _invoiceFormCubit,
            errors: _invoiceBloc.getValidationErrors,
          ),
          _statusHint(),
          CustomAdjustmentNotePlutoTable(
            invoice: _invoiceBloc.getAdjustmentNoteEntity,
            readOnly: isSavedAdjustmentNote,
          ),
          CustomAdjustmentNoteFooter(
            adjustmentNoteFormCubit: _invoiceFormCubit,
            adjustmentNoteBloc: _invoiceBloc,
            enableEditing: !isSavedAdjustmentNote,
          ),
        ],
      ),
    );
  }

  Visibility _statusHint() {
    return Visibility(
      visible: _invoiceBloc.getAdjustmentNoteEntity.status == Status.saved.name,
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
