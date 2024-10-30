import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_date_picker.dart';
import 'package:ngu_app/core/widgets/custom_input_filed.dart';

import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';
import 'package:ngu_app/features/journals/presentation/bloc/journal_bloc.dart';
import 'package:ngu_app/features/journals/presentation/widgets/custom_journal_vouchers_pluto_table.dart';
import 'package:ngu_app/features/journals/presentation/widgets/journal_vouchers_tool_bar.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class JournalVouchers extends StatefulWidget {
  const JournalVouchers({super.key});

  @override
  State<JournalVouchers> createState() => _JournalVouchersState();
}

class _JournalVouchersState extends State<JournalVouchers> {
  late final JournalBloc _journalBloc;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _journalIdController;
  late final TextEditingController _journalDocumentNumberController;
  late final TextEditingController _journalCreatedAtController;
  late final TextEditingController _journalDescriptionController;
  PlutoGridStateManager? stateManger;

  @override
  void initState() {
    _journalBloc = sl<JournalBloc>()..add(const ShowJournalEvent(journalId: 1));

    _journalIdController = TextEditingController();
    _journalDocumentNumberController = TextEditingController();
    _journalCreatedAtController = TextEditingController();
    _journalDescriptionController = TextEditingController();
    super.initState();
  }

  _updateTextEditingController(JournalEntity journal) {
    _journalIdController.text = journal.id.toString();
    _journalDocumentNumberController.text = journal.document;
    _journalCreatedAtController.text = journal.createdAt;
    _journalDescriptionController.text = journal.description;
  }

  @override
  void dispose() {
    _journalBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _journalBloc,
      child: BlocBuilder<JournalBloc, JournalState>(
        builder: (context, state) {
          if (state is LoadedJournalState) {
            _updateTextEditingController(state.journalEntity);

            return _pageBody(state.journalEntity);
          }
          if (state is ErrorJournalState) {
            return Center(
              child: MessageScreen(text: state.message),
            );
          }
          return Center(child: Loaders.loading());
        },
      ),
    );
  }

  ListView _pageBody(JournalEntity journalEntity) {
    return ListView(
      children: [
        JournalVouchersToolBar(
          journalEntity: journalEntity,
        ),
        const Divider(),
        _buildHeader(context),
        CustomJournalVouchersPlutoTable(
          journalEntity: journalEntity,
        ),
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
