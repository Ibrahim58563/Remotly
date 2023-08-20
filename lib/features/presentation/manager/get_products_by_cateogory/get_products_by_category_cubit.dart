import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store/core/models/product/product_model.dart';
import 'package:store/core/repo/home_repo.dart';

part 'get_products_by_category_state.dart';

class GetProductsByCategoryCubit extends Cubit<GetProductsByCategoryState> {
  GetProductsByCategoryCubit(this.homeRepo, this.categoryName)
      : super(GetProductsByCategoryInitial());
  final String categoryName;
  final HomeRepo homeRepo;
  List<ProductModel> categoryProducts = [];

  Future<void> getCategory(String categoryName) async {
    try {
      emit(GetProductsByCategoryLoading());
      var result = await homeRepo.getCategory(categoryName.toLowerCase());
      result.fold(
        (failure) {
          emit(GetProductsByCategoryFailure(failure.errMessage));
        },
        (categoryProducts) {
          // print(categoryProducts);
          emit(GetProductsByCategorySuccess(categoryProducts));
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
