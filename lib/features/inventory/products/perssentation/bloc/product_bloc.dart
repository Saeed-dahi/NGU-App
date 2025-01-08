import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final result = await showProductUseCase(event.id);

    result.fold((failure) {
      emit(ErrorProductsState(message: failure.errors['error']));
    }, (product) {
      emit(LoadedProductState(enableEditing: false, productEntity: product));
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
}
