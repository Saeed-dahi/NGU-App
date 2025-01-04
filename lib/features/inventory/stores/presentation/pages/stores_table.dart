import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/inventory/stores/presentation/bloc/store_bloc.dart';
import 'package:ngu_app/features/inventory/stores/presentation/widgets/custom_stores_pluto_table.dart';
import 'package:ngu_app/features/inventory/stores/presentation/widgets/stores_toolbar.dart';

class StoresTable extends StatefulWidget {
  const StoresTable({super.key});

  @override
  State<StoresTable> createState() => _StoresTableState();
}

class _StoresTableState extends State<StoresTable> {
  late final StoreBloc _storeBloc;
  @override
  void initState() {
    _storeBloc = sl<StoreBloc>()..add(GetStoresEvent());
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  Future<void> _refresh() async {
    _storeBloc.add(GetStoresEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _storeBloc,
      child: CustomRefreshIndicator(
        onRefresh: _refresh,
        content: ListView(
          children: [
            BlocBuilder<StoreBloc, StoreState>(
              builder: (context, state) {
                if (state is LoadedStoresState) {
                  return Column(
                    children: [
                      StoresToolbar(enableEditing: state.enableEditing),
                      CustomStoresPlutoTable(
                        stores: state.storeEntity,
                        enableEditing: state.enableEditing,
                      ),
                    ],
                  );
                }
                if (state is ErrorStoresState) {
                  return Center(
                    child: MessageScreen(text: state.message),
                  );
                }
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  child: Center(
                    child: Loaders.loading(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
