import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';

import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';

import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';
import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';
import 'package:ngu_app/features/journals/presentation/bloc/journal_bloc.dart';
import 'package:ngu_app/features/journals/presentation/pages/create_journal.dart';
import 'package:ngu_app/features/journals/presentation/widgets/custom_journal_fields.dart';
import 'package:ngu_app/features/journals/presentation/widgets/custom_journal_vouchers_pluto_table.dart';
import 'package:ngu_app/features/journals/presentation/widgets/journal_vouchers_tool_bar.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class JournalVouchers extends StatefulWidget {
  final int? journalId;
  const JournalVouchers({super.key, this.journalId});

  @override
  State<JournalVouchers> createState() => _JournalVouchersState();
}

class _JournalVouchersState extends State<JournalVouchers> {
  late JournalBloc _journalBloc;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _journalIdController;
  late final TextEditingController _journalDocumentNumberController;
  late final TextEditingController _journalDateController;
  late final TextEditingController _journalDescriptionController;
  PlutoGridStateManager? stateManger;

  @override
  void initState() {
    _journalBloc = sl<JournalBloc>()..add(GetAccountNameEvent());

    _journalIdController = TextEditingController();
    _journalDocumentNumberController = TextEditingController();
    _journalDateController = TextEditingController();
    _journalDescriptionController = TextEditingController();
    super.initState();
  }

  _updateTextEditingController(JournalEntity journal) {
    _journalIdController.text = journal.id.toString();
    _journalDocumentNumberController.text = journal.document;
    _journalDateController.text = journal.date;
    _journalDescriptionController.text = journal.description;
  }

  @override
  void dispose() {
    _journalBloc.close();

    _journalIdController.dispose();
    _journalDocumentNumberController.dispose();
    _journalDateController.dispose();
    _journalDescriptionController.dispose();
    super.dispose();
  }

  JournalEntity journalEntity(Enum status) {
    return JournalEntity(
      id: _journalBloc.getJournalEntity.id,
      document: _journalDocumentNumberController.text,
      description: _journalDescriptionController.text,
      status: status.name,
      transactions: _journalBloc.transactions,
      date: _journalDateController.text,
    );
  }

  void _onSaveAsDraft() {
    _journalBloc.add(UpdateJournalEvent(
      journalEntity: journalEntity(Status.draft),
    ));
  }

  void _onSaveAsSaved() {
    _journalBloc.add(UpdateJournalEvent(
      journalEntity: journalEntity(Status.saved),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: _refresh,
      child: BlocProvider(
        create: (context) => _journalBloc,
        child: BlocConsumer<JournalBloc, JournalState>(
          listener: (context, state) {
            if (state is GetAccountNameState) {
              _journalBloc
                  .add(ShowJournalEvent(journalId: widget.journalId ?? 1));
            }
          },
          builder: (context, state) {
            if (state is LoadedJournalState) {
              _updateTextEditingController(state.journalEntity);
              return _pageBody(state.journalEntity);
            }

            if (state is ErrorJournalState) {
              if (state.message == AppStrings.notFound.tr) {
                context.read<TabCubit>().removeLastTab();
                context.read<TabCubit>().addNewTab(
                    title: '${'add'.tr} ${'journal_voucher'.tr}',
                    content: CreateJournal(
                      accountsName: _journalBloc.accountsName,
                    ));
              }

              return Column(
                children: [
                  JournalVouchersToolBar(
                    journalId: _journalBloc.getJournalEntity?.id,
                  ),
                  Center(
                    child: MessageScreen(text: state.message),
                  ),
                ],
              );
            }
            return Center(child: Loaders.loading());
          },
        ),
      ),
    );
  }

  ListView _pageBody(JournalEntity journalEntity) {
    final bool isSavedJournal =
        _journalBloc.getJournalEntity?.status == Status.saved.name;
    return ListView(
      children: [
        JournalVouchersToolBar(
          journalId: _journalBloc.getJournalEntity?.id,
          accountsName: _journalBloc.accountsName,
          onSaveAsDraft: isSavedJournal ? _onSaveAsDraft : null,
          onSaveAsSaved: isSavedJournal ? null : _onSaveAsSaved,
        ),
        const Divider(),
        _buildHeader(context),
        CustomJournalVouchersPlutoTable(
          journalEntity: journalEntity,
          accountsName: _journalBloc.accountsName,
          readOnly: isSavedJournal,
        ),
      ],
    );
  }

  _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // TODO: Add enable option
        CustomJournalFields(
            formKey: _formKey,
            journalIdController: _journalIdController,
            journalDocumentNumberController: _journalDocumentNumberController,
            journalCreatedAtController: _journalDateController,
            journalDescriptionController: _journalDescriptionController,
            journalBloc: _journalBloc),
        _statusHint()
      ],
    );
  }

  Visibility _statusHint() {
    return Visibility(
      visible: _journalBloc.getJournalEntity.status == Status.saved.name,
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

  Future<void> _refresh() async {
    _journalBloc
        .add(ShowJournalEvent(journalId: _journalBloc.getJournalEntity?.id));
    _journalBloc.add(GetAccountNameEvent());
  }
}
