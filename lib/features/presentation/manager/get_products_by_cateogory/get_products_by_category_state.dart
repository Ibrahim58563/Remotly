part of 'get_products_by_category_cubit.dart';

sealed class GetProductsByCategoryState extends Equatable {
  const GetProductsByCategoryState();

  @override
  List<Object> get props => [];
}

final class GetProductsByCategoryInitial extends GetProductsByCategoryState {}

final class GetProductsByCategorySuccess extends GetProductsByCategoryState {
  final List<ProductModel> categoryProducts;

  const GetProductsByCategorySuccess(this.categoryProducts);
}

final class GetProductsByCategoryLoading extends GetProductsByCategoryState {}

final class GetProductsByCategoryFailure extends GetProductsByCategoryState {
  final String errMessage;

  const GetProductsByCategoryFailure(this.errMessage);
}
