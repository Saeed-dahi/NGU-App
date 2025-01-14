import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_entity.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_unit_entity.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/create_product_unit_use_case.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/create_product_use_case.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/get_products_use_case.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/show_product_use_case.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/update_product_unit_use_case.dart';
import 'package:ngu_app/features/inventory/products/domain/use_cases/update_product_use_case.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final ShowProductUseCase showProductUseCase;
  final CreateProductUseCase createProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final CreateProductUnitUseCase createProductUnitUseCase;
  final UpdateProductUnitUseCase updateProductUnitUseCase;

  late ProductEntity product;
  late PlutoGridController plutoGridController;

  ProductBloc(
      {required this.getProductsUseCase,
      required this.showProductUseCase,
      required this.createProductUseCase,
      required this.updateProductUseCase,
      required this.createProductUnitUseCase,
      required this.updateProductUnitUseCase})
      : super(ProductInitial()) {
    on<GetProductsEvent>(_onGetProducts);
    on<ShowProductEvent>(_onShowProduct);
    on<CreateProductEvent>(_onCreateProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<ToggleEditingEvent>(_onToggleEditing);
    on<UpdateProductCategoryEvent>(_onUpdateCategory);
    on<CreateProductUnitEvent>(_onCreateProductUnit);
    on<UpdateProductUnitEvent>(_onUpdateProductUnit);
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
      if (failure is ValidationFailure) {
        emit(ValidationProductState(errors: failure.errors));
      } else {
        emit(ErrorProductsState(message: failure.errors['error']));
      }
    }, (data) {
      Get.back();
      add(ShowProductEvent(id: data.id!));
    });
  }

  FutureOr<void> _onUpdateProduct(
      UpdateProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingProductsState());
    final result = await updateProductUseCase(
        event.productEntity, event.files, event.filesToDelete);
    product = event.productEntity;

    result.fold((failure) {
      if (failure is ValidationFailure) {
        emit(ValidationProductState(errors: failure.errors));
      } else {
        emit(ErrorProductsState(message: failure.errors['error']));
      }
    }, (_) {
      add(ShowProductEvent(id: product.id!));
    });
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

  FutureOr<void> _onUpdateCategory(
      UpdateProductCategoryEvent event, Emitter<ProductState> emit) {
    emit(LoadingProductsState());

    emit(LoadedProductState(
        productEntity: product, enableEditing: true, category: event.category));
  }

  FutureOr<void> _onCreateProductUnit(
      CreateProductUnitEvent event, Emitter<ProductState> emit) async {
    emit(LoadingProductsState());
    final result = await createProductUnitUseCase(
        event.productUnitEntity, event.baseUnitId);
    result.fold((failure) {
      if (failure is ValidationFailure) {
        emit(ValidationProductState(errors: failure.errors));
      } else {
        emit(ErrorProductsState(message: failure.errors['error']));
      }
    }, (_) {
      add(ShowProductEvent(id: product.id!));
    });
  }

  FutureOr<void> _onUpdateProductUnit(
      UpdateProductUnitEvent event, Emitter<ProductState> emit) async {
    final result = await updateProductUnitUseCase(event.productUnitEntity);
    result.fold((failure) {
      if (failure is ValidationFailure) {
        emit(ValidationProductState(errors: failure.errors));
      } else {
        emit(ErrorProductsState(message: failure.errors['error']));
      }
    }, (data) {
      product = data;
      emit(LoadedProductState(productEntity: product, enableEditing: true));
    });
  }
}
