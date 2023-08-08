import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store/core/models/product/product_model.dart';
import 'package:store/core/repo/home_repo.dart';

part 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsCubit(this.homeRepo) : super(AllProductsInitial());
  final HomeRepo homeRepo;
  Future<void> fetchAllProducts() async {
    emit(AllProductsLoading());
    var result = await homeRepo.fetchAllProducts();
    result.fold((failure) {
      emit(AllProductsFailure(failure.errMessage));
    }, (products) {
      emit(AllProductsSuccess(products));
    });
  }
  
}
