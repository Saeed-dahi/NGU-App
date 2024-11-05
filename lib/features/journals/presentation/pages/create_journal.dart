import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';

import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/home/presentation/cubit/tab_cubit.dart';
import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';
import 'package:ngu_app/features/journals/presentation/bloc/journal_bloc.dart';
import 'package:ngu_app/features/journals/presentation/pages/journal_vouchers.dart';
import 'package:ngu_app/features/journals/presentation/widgets/custom_journal_vouchers_pluto_table.dart';
import 'package:ngu_app/features/journals/presentation/widgets/journal_vouchers_tool_bar.dart';

class CreateJournal extends StatefulWidget {
  const CreateJournal({super.key});

  @override
  State<CreateJournal> createState() => _CreateJournalState();
}

class _CreateJournalState extends State<CreateJournal> {
  late final JournalBloc _journalBloc;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _journalIdController;
  late final TextEditingController _journalDocumentNumberController;
  late final TextEditingController _journalCreatedAtController;
  late final TextEditingController _journalDescriptionController;

  JournalEntity journalEntity(Enum status) {
    return JournalEntity(
      document: _journalDocumentNumberController.text,
      description: _journalDescriptionController.text,
      status: status.name,
      transactions: _journalBloc.transactions,
      createdAt: _journalCreatedAtController.text,
    );
  }

  @override
  void initState() {
    _journalBloc = sl<JournalBloc>();

    _journalIdController = TextEditingController();
    _journalDocumentNumberController = TextEditingController();
    _journalCreatedAtController = TextEditingController();
    _journalDescriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _journalBloc.close();

    _journalIdController.dispose();
    _journalDocumentNumberController.dispose();
    _journalCreatedAtController.dispose();
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
        CustomJournalVouchersPlutoTable(),
      ],
    );
  }

  _buildHeader(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.2,
                child: CustomInputField(
                  inputType: TextInputType.text,
                  controller: _journalIdController,
                  label: 'code'.tr,
                  readOnly: true,
                  enabled: false,
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.2,
                child: CustomInputField(
                  inputType: TextInputType.text,
                  controller: _journalDocumentNumberController,
                  label: 'document_number'.tr,
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.2,
                child: CustomDatePicker(
                    dateInput: _journalCreatedAtController,
                    labelText: 'created_at'.tr),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.2,
                child: CustomInputField(
                  inputType: TextInputType.text,
                  controller: _journalDescriptionController,
                  label: 'description'.tr,
                  onEditingComplete: () {
                    _journalBloc.getStateManger.setCurrentCell(
                        _journalBloc
                            .getStateManger.rows.first.cells.values.first,
                        0);
                    _journalBloc.getStateManger.setKeepFocus(true);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
