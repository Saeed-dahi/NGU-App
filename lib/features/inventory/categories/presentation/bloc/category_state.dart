part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

class LoadedCategoriesState extends CategoryState {
  final List<CategoryEntity> categories;

  const LoadedCategoriesState({required this.categories});

  @override
  List<Object> get props => [categories];
}

class LoadingCategoriesState extends CategoryState {}

class ErrorCategoriesState extends CategoryState {
  final String message;

  const ErrorCategoriesState({required this.message});

  @override
  List<Object> get props => [message];
}

class ValidationCategoryState extends CategoryState {
  final Map<String, dynamic> errors;

  const ValidationCategoryState({required this.errors});
  @override
  List<Object> get props => [errors];
}
