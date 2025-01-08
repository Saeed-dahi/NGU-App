part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends ProductEvent {
  final List<ProductEntity> products;

  const GetProductsEvent({required this.products});
}

class ShowProductEvent extends ProductEvent {
  final int id;
  final String? direction;

  const ShowProductEvent({required this.id, required this.direction});
}

class CreateProductEvent extends ProductEvent {
  final ProductEntity productEntity;

  const CreateProductEvent({required this.productEntity});
}

class UpdateProductEvent extends ProductEvent {
  final ProductEntity productEntity;

  const UpdateProductEvent({required this.productEntity});
}

class ToggleEditingEvent extends ProductEvent {
  final bool enableEditing;

  const ToggleEditingEvent({required this.enableEditing});
}
