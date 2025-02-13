import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';

import 'package:ngu_app/features/inventory/products/presentation/bloc/product_bloc.dart';
import 'package:ngu_app/features/inventory/products/presentation/widgets/custom_product_pluto_table.dart';

class ProductsTable extends StatefulWidget {
  final String localeSearchQuery;
  const ProductsTable({super.key, this.localeSearchQuery = ''});

  @override
  State<ProductsTable> createState() => _ProductsTableState();
}

class _ProductsTableState extends State<ProductsTable> {
  late final ProductBloc _productBloc;

  @override
  void initState() {
    _productBloc = sl<ProductBloc>()..add(GetProductsEvent());
    super.initState();
  }

  Future<void> _refresh() async {
    _productBloc.add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _productBloc,
      child: CustomRefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          children: [
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is LoadedAllProductsState) {
                  return CustomProductPlutoTable(
                    products: state.products,
                    localeSearchQuery: widget.localeSearchQuery,
                  );
                }
                if (state is ErrorProductsState) {
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
            ),
          ],
        ),
      ),
    );
  }
}
