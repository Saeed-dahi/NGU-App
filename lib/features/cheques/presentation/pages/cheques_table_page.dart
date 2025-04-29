import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/cheques/presentation/blocs/cheque_bloc/cheque_bloc.dart';
import 'package:ngu_app/features/cheques/presentation/widgets/custom_cheques_pluto_table.dart';

class ChequesTablePage extends StatefulWidget {
  final int? accountId;
  const ChequesTablePage({super.key, this.accountId});

  @override
  State<ChequesTablePage> createState() => _ChequesTablePageState();
}

class _ChequesTablePageState extends State<ChequesTablePage> {
  late final ChequeBloc _chequeBloc;

  @override
  void initState() {
    _chequeBloc = sl<ChequeBloc>();
    _initBloc();
    super.initState();
  }

  void _initBloc() {
    if (widget.accountId != null) {
      _chequeBloc.add(GetChequesPerAccountEvent(accountId: widget.accountId!));
    } else {
      _chequeBloc.add(GetAllChequesEvent());
    }
  }

  @override
  void dispose() {
    _chequeBloc.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    _initBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _chequeBloc,
      child: CustomRefreshIndicator(
        child: ListView(
          children: [
            BlocBuilder<ChequeBloc, ChequeState>(
              builder: (context, state) {
                if (state is LoadedChequesState) {
                  return CustomChequesPlutoTable(
                    cheques: state.cheques,
                  );
                }
                if (state is ErrorChequeState) {
                  return MessageScreen(text: state.message);
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
