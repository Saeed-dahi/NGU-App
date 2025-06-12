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
import 'package:ngu_app/features/adjustment_notes/presentation/pages/adjustment_note_page.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/adjustment_note_tool_bar.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/custom_adjustment_note_fields.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/custom_adjustment_note_footer.dart';
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
  late final AdjustmentNoteBloc _invoiceBloc;

  late final AdjustmentNoteFormCubit _invoiceFormCubit;

  @override
  void initState() {
    _invoiceBloc = sl<AdjustmentNoteBloc>()
      ..add(GetCreateAdjustmentNoteFormData(type: widget.type));

    _invoiceFormCubit = AdjustmentNoteFormCubit(
        invoiceBloc: _invoiceBloc, invoiceType: widget.type);

    super.initState();
  }

  _initControllers(AdjustmentNoteEntity invoice) {
    _invoiceFormCubit.initControllers(invoice);
  }

  @override
  void dispose() {
    _invoiceBloc.close();
    _invoiceFormCubit.disposeControllers();

    super.dispose();
  }

  void onSaveAsDraft() {
    if (_invoiceFormCubit.validateForm()) {
      _invoiceBloc.add(CreateAdjustmentNoteEvent(
          adjustmentNote: _invoiceFormCubit.invoiceEntity(Status.draft)));
    } else {
      ShowSnackBar.showValidationSnackbar(messages: ['required'.tr]);
    }
  }

  void onSaveAsSaved() {
    if (_invoiceFormCubit.validateForm()) {
      _invoiceBloc.add(CreateAdjustmentNoteEvent(
          adjustmentNote: _invoiceFormCubit.invoiceEntity(Status.saved)));
    } else {
      ShowSnackBar.showValidationSnackbar(messages: ['required'.tr]);
    }
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
      child: BlocConsumer<AdjustmentNoteBloc, AdjustmentNoteState>(
        listener: (context, state) {
          if (state is CreatedAdjustmentNoteState) {
            context.read<TabCubit>().removeCurrentTab();
            context.read<TabCubit>().addNewTab(
                title: widget.type.tr,
                content: AdjustmentNotePage(
                  type: widget.type,
                  invoiceId: _invoiceBloc.getAdjustmentNoteEntity.id!,
                ));
          }
        },
        builder: (context, state) {
          if (state is ErrorAdjustmentNoteState) {
            return Center(child: MessageScreen(text: state.error));
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

  void onAdjustmentNoteSearch() {
    context.read<TabCubit>().addNewTab(
        title: widget.type.tr,
        content: AdjustmentNotePage(
            type: widget.type,
            invoiceId:
                int.parse(_invoiceFormCubit.invoiceSearchNumController.text)));
  }

  Widget _pageBody() {
    return CustomAdjustmentNotePageContainer(
      type: _invoiceBloc.getAdjustmentNoteEntity.invoiceType!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AdjustmentNoteToolBar(
            // invoice: _invoiceBloc.getAdjustmentNoteEntity,
            onSaveAsDraft: onSaveAsDraft,
            onSaveAsSaved: onSaveAsSaved,
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
              _invoiceTabWidgets(false),
              _invoiceOptionPage(false),
              SizedBox(),
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
          CustomAdjustmentNotePlutoTable(
            readOnly: isSavedAdjustmentNote,
            invoice: _invoiceBloc.getAdjustmentNoteEntity,
          ),
          CustomAdjustmentNoteFooter(
            adjustmentNoteFormCubit: _invoiceFormCubit,
            adjustmentNoteBloc: _invoiceBloc,
            enableEditing: true,
          ),
        ],
      ),
    );
  }
}
