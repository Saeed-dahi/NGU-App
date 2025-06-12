import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/blocs/adjustment_note_bloc/adjustment_note_bloc.dart';
import 'package:ngu_app/features/adjustment_notes/presentation/widgets/custom_adjustment_notes_pluto_table.dart';

class AdjustmentNotesPage extends StatefulWidget {
  final String type;
  const AdjustmentNotesPage({super.key, required this.type});

  @override
  State<AdjustmentNotesPage> createState() => _AdjustmentNotesPageState();
}

class _AdjustmentNotesPageState extends State<AdjustmentNotesPage> {
  late final AdjustmentNoteBloc _invoiceBloc;

  @override
  void initState() {
    _invoiceBloc = sl<AdjustmentNoteBloc>()
      ..add(GetAllAdjustmentNoteEvent(type: widget.type));
    super.initState();
  }

  @override
  void dispose() {
    _invoiceBloc.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    _invoiceBloc.add(GetAllAdjustmentNoteEvent(type: widget.type));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _invoiceBloc,
      child: CustomRefreshIndicator(
        child: ListView(
          children: [
            BlocBuilder<AdjustmentNoteBloc, AdjustmentNoteState>(
              builder: (context, state) {
                if (state is LoadedAllAdjustmentNotesState) {
                  return CustomAdjustmentNotesPlutoTable(
                    invoices: state.adjustmentNotes,
                  );
                }
                if (state is ErrorAdjustmentNoteState) {
                  return Center(
                    child: MessageScreen(text: state.error),
                  );
                }
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  child: Center(
                    child: Loaders.loading(),
                  ),
                );
              },
            ),
          ],
        ),
        onRefresh: () => _refresh(),
      ),
    );
  }
}
