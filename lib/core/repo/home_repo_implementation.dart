import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store/core/models/product/product_model.dart';
import 'package:store/core/repo/failure.dart';
import 'package:store/core/repo/home_repo.dart';
import 'package:store/core/utils/api_service.dart';

class HomeRepoImplementation extends HomeRepo {
  final ApiService apiService;

  HomeRepoImplementation(this.apiService);
  @override
  Future<Either<Failure, List<ProductModel>>> addProduct() {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchAllProducts() async {
    try {
      List<ProductModel> products = [];
      var data = await apiService.get(endPoint: '/products');
      print("data");
      for (int i = 0; i < data.length;i++) {
        products.add(ProductModel.fromJson(data[i]));
        print("+1 product");
      }
      // print(products);
      return right(products);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure('errMessage'));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getCategory() {
    // TODO: implement getCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductModel>>> updateProduct() {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
