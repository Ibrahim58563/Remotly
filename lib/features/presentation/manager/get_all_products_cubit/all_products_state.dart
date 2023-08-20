part of 'all_products_cubit.dart';
sealed class AllProductsState extends Equatable {
  const AllProductsState();

  @override
  List<Object> get props => [];
}

class AllProductSearchSuccess extends AllProductsState {
  final List<ProductModel> filteredProducts;

  AllProductSearchSuccess(this.filteredProducts);

  @override
  List<Object> get props => [filteredProducts];
}

class AllProductsInitial extends AllProductsState {}

class AllProductsLoading extends AllProductsState {}

class AllProductsSuccess extends AllProductsState {
  final List<ProductModel> products;

  AllProductsSuccess(this.products);

  @override
  List<Object> get props => [products];
}

class AllProductsFailure extends AllProductsState {
  final String failure;

  AllProductsFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
