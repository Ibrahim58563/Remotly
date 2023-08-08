import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:store/core/models/cart_model/cart_hive_model.dart';
import 'package:store/core/models/product/product_model.dart';
import 'package:collection/collection.dart';
part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());
  final List<ProductModel> _cartItems = [];
  final Box<CartHiveModel> _cartBox = Hive.box<CartHiveModel>('cart');
  void addToCart(ProductModel product) {
    var existingCartItem =
        _cartBox.values.firstWhereOrNull((item) => item.id == product.id);
    if (existingCartItem != null) {
      existingCartItem.quantity += 1;
      print("already exists, increase it's quantity");
    } else {
      _cartItems.add(ProductModel(
          id: product.id,
          title: product.title,
          image: product.image,
          rating: product.rating,
          // description: product.description,
          price: product.price,
          quantity: 1));
      print("one item added to Cart");
      _cartBox.put(
          product.id,
          CartHiveModel(
            id: product.id,
            title: product.title,
            image: product.image,
            rating: product.rating!.rate,
            price: product.price,
            quantity: 1,
          ));
      print(_cartBox.length);
      print("one item added to Hive");
    }
    emit(AddToCartSuccess(_cartItems));
  }
}
