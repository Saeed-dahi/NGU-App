import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/inventory/categories/domain/entities/category_entity.dart';
import 'package:ngu_app/features/inventory/categories/domain/use_cases/create_category_use_case.dart';
import 'package:ngu_app/features/inventory/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:ngu_app/features/inventory/categories/domain/use_cases/update_category_use_case.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final CreateCategoryUseCase createCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;

  late PlutoGridController plutoGridController;

  CategoryBloc(
      {required this.getCategoriesUseCase,
      required this.createCategoryUseCase,
      required this.updateCategoryUseCase})
      : super(CategoryInitial()) {
    on<GetCategoriesEvent>(_onGetCategories);
    on<CreateCategoryEvent>(_onCreateCategory);
    on<UpdateCategoryEvent>(_onUpdateCategory);
  }

  FutureOr<void> _onGetCategories(
      GetCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(LoadingCategoriesState());
    final result = await getCategoriesUseCase();

    result.fold((failure) {
      emit(ErrorCategoriesState(message: failure.errors['error']));
    }, (data) {
      emit(LoadedCategoriesState(categories: data));
    });
  }

  FutureOr<void> _onCreateCategory(
      CreateCategoryEvent event, Emitter<CategoryState> emit) {
    _createOrUpdateStore(event, emit, createCategoryUseCase);
  }

  FutureOr<void> _onUpdateCategory(
      UpdateCategoryEvent event, Emitter<CategoryState> emit) {
    _createOrUpdateStore(event, emit, updateCategoryUseCase);
  }

  FutureOr<void> _createOrUpdateStore(
      dynamic event, Emitter<CategoryState> emit, dynamic useCase) async {
    final result = await useCase(event.storeEntity);
    result.fold((failure) {
      if (failure is ValidationFailure) {
        emit(ValidationCategoryState(errors: failure.errors));
      } else {
        emit(ErrorCategoriesState(message: failure.errors['error']));
      }
    }, (_) async {
      Get.back();
      add(GetCategoriesEvent());
    });
  }
}
