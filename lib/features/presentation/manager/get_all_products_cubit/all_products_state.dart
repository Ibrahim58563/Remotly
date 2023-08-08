part of 'all_products_cubit.dart';

sealed class AllProductsState extends Equatable {
  const AllProductsState();

  @override
  List<Object> get props => [];
}

final class AllProductsInitial extends AllProductsState {}

final class AllProductsLoading extends AllProductsState {}

final class AllProductsSuccess extends AllProductsState {
  final List<ProductModel> products;

  const AllProductsSuccess(this.products);
}

final class AllProductsFailure extends AllProductsState {
  final String failure;

  const AllProductsFailure(this.failure);
}
