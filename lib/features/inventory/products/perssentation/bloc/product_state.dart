part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

class LoadingProductsState extends ProductState {}

class LoadedProductState extends ProductState {
  final ProductEntity productEntity;
  final bool enableEditing;

  const LoadedProductState(
      {required this.productEntity, required this.enableEditing});
}

class ErrorProductsState extends ProductState {
  final String message;

  const ErrorProductsState({required this.message});
}

class ValidationProductState extends ProductState {
  final Map<String, dynamic> errors;

  const ValidationProductState({required this.errors});
}

class LoadedAllProductsState extends ProductState {
  final List<ProductEntity> products;

  const LoadedAllProductsState({required this.products});
}
