part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends ProductEvent {}

class ShowProductEvent extends ProductEvent {
  final int id;
  final String? direction;

  const ShowProductEvent({required this.id, this.direction});
}

class CreateProductEvent extends ProductEvent {
  final ProductEntity productEntity;

  const CreateProductEvent({required this.productEntity});
}

class UpdateProductEvent extends ProductEvent {
  final ProductEntity productEntity;
  final List<File> files;
  final List<String> filesToDelete;

  const UpdateProductEvent({required this.productEntity,required this.files,required this.filesToDelete});
}

class ToggleEditingEvent extends ProductEvent {
  final bool enableEditing;

  const ToggleEditingEvent({required this.enableEditing});
}

class UpdateProductCategoryEvent extends ProductEvent {
  final Map<String, dynamic> category;

  const UpdateProductCategoryEvent({required this.category});
}
