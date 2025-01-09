import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_entity.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/create_product_use_case.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/get_products_use_case.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/show_product_use_case.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/update_product_use_case.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final ShowProductUseCase showProductUseCase;
  final CreateProductUseCase createProductUseCase;
  final UpdateProductUseCase updateProductUseCase;

  late ProductEntity product;
  late PlutoGridController plutoGridController;

  ProductBloc(
      {required this.getProductsUseCase,
      required this.showProductUseCase,
      required this.createProductUseCase,
      required this.updateProductUseCase})
      : super(ProductInitial()) {
    on<GetProductsEvent>(_onGetProducts);
    on<ShowProductEvent>(_onShowProduct);
    on<CreateProductEvent>(_onCreateProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<ToggleEditingEvent>(_onToggleEditing);
  }

  FutureOr<void> _onGetProducts(
      GetProductsEvent event, Emitter<ProductState> emit) async {
    emit(LoadingProductsState());
    final result = await getProductsUseCase();

    result.fold((failure) {
      emit(ErrorProductsState(message: failure.errors['error']));
    }, (products) {
      emit(LoadedAllProductsState(products: products));
    });
  }

  FutureOr<void> _onShowProduct(
      ShowProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingProductsState());
    final result = await showProductUseCase(event.id, event.direction);

    result.fold((failure) {
      emit(ErrorProductsState(message: failure.errors['error']));
    }, (data) {
      product = data;

      emit(LoadedProductState(enableEditing: false, productEntity: data));
    });
  }

  FutureOr<void> _onCreateProduct(
      CreateProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingProductsState());
    final result = await createProductUseCase(event.productEntity);

    result.fold((failure) {
      emit(ErrorProductsState(message: failure.errors['error']));
    }, (_) {});
  }

  FutureOr<void> _onUpdateProduct(
      UpdateProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingProductsState());
    final result = await updateProductUseCase(event.productEntity);

    result.fold((failure) {
      emit(ErrorProductsState(message: failure.errors['error']));
    }, (_) {});
  }

  FutureOr<void> _onToggleEditing(
      ToggleEditingEvent event, Emitter<ProductState> emit) {
    final currentState = state as LoadedProductState;
    emit(LoadingProductsState());

    emit(LoadedProductState(
      productEntity: currentState.productEntity,
      enableEditing: event.enableEditing,
    ));
  }

  void searchProduct(String query) {
    plutoGridController.stateManager!.setFilter(
      (row) {
        final arName = FormatterClass.normalizeArabic(
            row.cells['ar_name']!.value.toString().toLowerCase());
        final enName = row.cells['en_name']!.value.toString().toLowerCase();
        final code = row.cells['code']!.value.toString();

        var result = arName.contains(
                FormatterClass.normalizeArabic(query.toLowerCase())) ||
            code.contains(query.toLowerCase()) ||
            enName.contains(query.toLowerCase());
        return result;
      },
    );
  }
}
