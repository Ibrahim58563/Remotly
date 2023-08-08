import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store/core/models/product/product_model.dart';
import 'package:collection/collection.dart';
part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());
  final List<ProductModel> _cartItems = [];
  void addToCart(ProductModel product) {
    var existingCartItem =
        _cartItems.firstWhereOrNull((item) => item.id == product.id);
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
    }
    emit(AddToCartSuccess(_cartItems));
  }
}
