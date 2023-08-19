import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/models/product/product_model.dart';
import 'package:store/core/repo/home_repo.dart';

part 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsCubit(this.homeRepo) : super(AllProductsInitial());
  final HomeRepo homeRepo;
  List<ProductModel> allProducts = [];
  Future<void> fetchAllProducts() async {
    emit(AllProductsLoading());
    var result = await homeRepo.fetchAllProducts();
    result.fold((failure) {
      emit(AllProductsFailure(failure.errMessage));
    }, (products) {
      allProducts = products;
      emit(AllProductsSuccess(products));
    });
  }

  void searchProducts(String query) {
    final filteredProducts = allProducts
        .where((product) =>
            product.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    print(filteredProducts);
    emit(AllProductsState.searchSuccess(filteredProducts));
  }
}
