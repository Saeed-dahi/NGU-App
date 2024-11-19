import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';

import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';
import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';
import 'package:ngu_app/features/journals/presentation/bloc/journal_bloc.dart';
import 'package:ngu_app/features/journals/presentation/pages/journal_vouchers.dart';
import 'package:ngu_app/features/journals/presentation/widgets/custom_journal_fields.dart';
import 'package:ngu_app/features/journals/presentation/widgets/custom_journal_vouchers_pluto_table.dart';
import 'package:ngu_app/features/journals/presentation/widgets/journal_vouchers_tool_bar.dart';

class CreateJournal extends StatefulWidget {
  final Map<String, dynamic> accountsName;
  final JournalEntity? journalEntity;
  const CreateJournal(
      {super.key, required this.accountsName, this.journalEntity});

  @override
  State<CreateJournal> createState() => _CreateJournalState();
}

class _CreateJournalState extends State<CreateJournal> {
  late final JournalBloc _journalBloc;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _journalIdController;
  late final TextEditingController _journalDocumentNumberController;
  late final TextEditingController _journalDateController;
  late final TextEditingController _journalDescriptionController;

  JournalEntity journalEntity(Enum status) {
    return JournalEntity(
      document: _journalDocumentNumberController.text,
      description: _journalDescriptionController.text,
      status: status.name,
      transactions: _journalBloc.transactions,
      date: _journalDateController.text,
    );
  }

  @override
  void initState() {
    _journalBloc = sl<JournalBloc>();

    _journalIdController = TextEditingController();
    _journalDocumentNumberController = TextEditingController();
    _journalDateController = TextEditingController();
    _journalDescriptionController = TextEditingController();
    super.initState();
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

  void _onSaveAsDraft() {
    _journalBloc.add(CreateJournalEvent(
      journalEntity: journalEntity(Status.draft),
    ));
  }

  void _onSaveAsSaved() {
    _journalBloc.add(CreateJournalEvent(
      journalEntity: journalEntity(Status.saved),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () {
        return Future.value();
      },
      content: BlocProvider(
        create: (context) => _journalBloc,
        child: BlocConsumer<JournalBloc, JournalState>(
          listener: (context, state) {
            context.read<TabCubit>().removeLastTab();
            context.read<TabCubit>().addNewTab(
                title: 'journal_vouchers'.tr,
                content: JournalVouchers(
                  journalId: _journalBloc.getJournalEntity?.id,
                ));
          },
          builder: (context, state) {
            if (state is LoadingJournalState) {
              return Center(child: Loaders.loading());
            }
            if (state is ErrorJournalState) {
              return Center(
                child: MessageScreen(text: state.message),
              );
            }

            return _pageBody();
          },
        ),
      ),
    );
  }

  ListView _pageBody() {
    return ListView(
      children: [
        JournalVouchersToolBar(
          onSaveAsDraft: _onSaveAsDraft,
          onSaveAsSaved: _onSaveAsSaved,
          journalId: _journalBloc.getJournalEntity?.id,
        ),
        const Divider(),
        _buildHeader(context),
        CustomJournalVouchersPlutoTable(
          accountsName: widget.accountsName,
          journalEntity: widget.journalEntity,
        ),
      ],
    );
  }

  _buildHeader(BuildContext context) {
    return CustomJournalFields(
        formKey: _formKey,
        journalIdController: _journalIdController,
        journalDocumentNumberController: _journalDocumentNumberController,
        journalCreatedAtController: _journalDateController,
        journalDescriptionController: _journalDescriptionController,
        journalBloc: _journalBloc);
  }
}
