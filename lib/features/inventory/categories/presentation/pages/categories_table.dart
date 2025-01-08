import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/inventory/categories/presentation/bloc/category_bloc.dart';
import 'package:ngu_app/features/inventory/categories/presentation/widgets/categories_toolbar.dart';
import 'package:ngu_app/features/inventory/categories/presentation/widgets/custom_categories_pluto_table.dart';

class CategoriesTable extends StatefulWidget {
  const CategoriesTable({super.key});

  @override
  State<CategoriesTable> createState() => _CategoriesTableState();
}

class _CategoriesTableState extends State<CategoriesTable> {
  late final CategoryBloc _categoryBloc;

  @override
  void initState() {
    _categoryBloc = sl<CategoryBloc>()..add(GetCategoriesEvent());
    super.initState();
  }

  @override
  void dispose() async {
    _categoryBloc.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    _categoryBloc.add(GetCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _categoryBloc,
      child: CustomRefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          children: [
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is LoadedCategoriesState) {
                  return Column(
                    children: [
                      const CategoriesToolbar(),
                      CustomCategoriesPlutoTable(
                        stores: state.categories,
                      ),
                    ],
                  );
                }
                if (state is ErrorCategoriesState) {
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
