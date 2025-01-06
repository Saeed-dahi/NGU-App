import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/inventory/units/presentation/bloc/unit_bloc.dart';
import 'package:ngu_app/features/inventory/units/presentation/widgets/custom_units_pluto_table.dart';
import 'package:ngu_app/features/inventory/units/presentation/widgets/unit_toolbar.dart';

class UnitsTable extends StatefulWidget {
  const UnitsTable({super.key});

  @override
  State<UnitsTable> createState() => _CategoriesTableState();
}

class _CategoriesTableState extends State<UnitsTable> {
  late final UnitBloc _unitBloc;
  @override
  void initState() {
    _unitBloc = sl<UnitBloc>()..add(GetUnitsEvent());
    super.initState();
  }

  @override
  void dispose() async {
    _unitBloc.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    _unitBloc.add(GetUnitsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _unitBloc,
      child: CustomRefreshIndicator(
        onRefresh: _refresh,
        content: ListView(
          children: [
            BlocBuilder<UnitBloc, UnitState>(
              builder: (context, state) {
                if (state is LoadedUnitsState) {
                  return Column(
                    children: [
                      const UnitToolbar(),
                      CustomUnitsPlutoTable(
                        units: state.units,
                      ),
                    ],
                  );
                }
                if (state is ErrorUnitsState) {
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
