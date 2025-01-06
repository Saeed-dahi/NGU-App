part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesEvent extends CategoryEvent {}

class CreateCategoryEvent extends CategoryEvent {
  final CategoryEntity categoryEntity;

  const CreateCategoryEvent({required this.categoryEntity});
}

class UpdateCategoryEvent extends CategoryEvent {
  final CategoryEntity categoryEntity;

  const UpdateCategoryEvent({required this.categoryEntity});
}
