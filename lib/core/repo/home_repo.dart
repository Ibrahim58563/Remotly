import 'package:dartz/dartz.dart';
import 'package:store/core/models/product/product_model.dart';

import 'failure.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ProductModel>>> fetchAllProducts();
  Future<Either<Failure, List<ProductModel>>> addProduct();
  Future<Either<Failure, List<ProductModel>>> updateProduct();
  Future<Either<Failure, List<ProductModel>>> getCategory();
}
