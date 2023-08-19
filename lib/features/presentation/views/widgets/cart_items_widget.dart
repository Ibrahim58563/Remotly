import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store/constants/images_assets.dart';
import 'package:store/core/models/product/product_model.dart';
import 'package:store/core/utils/strings.dart';

import '../../../../constants/text_styles.dart';
import '../../../../core/models/cart_model/cart_hive_model.dart';
import '../../../../core/utils/colors.dart';
import '../../manager/add_to_cart_cubit/add_to_cart_cubit.dart';

class CartItemsWidget extends StatefulWidget {
  const CartItemsWidget({super.key});

  @override
  State<CartItemsWidget> createState() => _CartItemsWidgetState();
}

class _CartItemsWidgetState extends State<CartItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ValueListenableBuilder<Box<CartHiveModel>>(
      valueListenable: Hive.box<CartHiveModel>('cart').listenable(),
      builder: (context, value, child) {
        final cartList = value.values.toList();
        if (value.isNotEmpty) {
          return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: value.values.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.grey.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.grey.withOpacity(0.2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Stack(alignment: Alignment.topRight, children: [
                              Center(
                                child:
                                    cartList[index].image == Assets.imagesChair
                                        ? Image.asset(
                                            cartList[index].image.toString(),
                                            height: 80,
                                          )
                                        : Image.network(
                                            cartList[index].image.toString(),
                                            height: 80,
                                          ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              cartList[index].title.toString(),
                              style: subtitle,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Rating: ${cartList[index].rating!}  ",
                                  style: greyText,
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.orange,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Quantity: ${cartList[index].quantity}",
                                  style: greyText,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${cartList[index].price.toString()}",
                                  style: subtitle.copyWith(
                                    color: AppColors.darkOrange,
                                  ),
                                ),
                                BlocListener<AddToCartCubit, AddToCartState>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      final CartHiveModel cartHiveModel =
                                          CartHiveModel(
                                        id: cartList[index].id,
                                        title: cartList[index].title,
                                        price: cartList[index].price,
                                        quantity: cartList[index].quantity,
                                        rating: cartList[index].rating,
                                        image: cartList[index].image,
                                        description:
                                            cartList[index].description,
                                      );
                                      final ProductModel product =
                                          ProductModel.fromCartHiveModel(
                                              cartHiveModel);
                                      context
                                          .read<AddToCartCubit>()
                                          .addToCart(product);
                                      setState(() {});
                                      print("Added from UI");
                                    },
                                    child: Icon(
                                      CupertinoIcons.cart_badge_plus,
                                      color: AppColors.darkOrange,
                                    ),
                                  ),
                                ),
                                BlocListener<AddToCartCubit, AddToCartState>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      final CartHiveModel cartHiveModel =
                                          CartHiveModel(
                                        id: cartList[index].id,
                                        title: cartList[index].title,
                                        price: cartList[index].price,
                                        quantity: cartList[index].quantity,
                                        rating: cartList[index].rating,
                                        image: cartList[index].image,
                                        description:
                                            cartList[index].description,
                                      );
                                      final ProductModel product =
                                          ProductModel.fromCartHiveModel(
                                              cartHiveModel);
                                      context
                                          .read<AddToCartCubit>()
                                          .removeFromCart(product);
                                      setState(() {});
                                      print("Added from UI");
                                    },
                                    child: Icon(
                                      CupertinoIcons.cart_badge_minus,
                                      color: AppColors.darkOrange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
        } else {
          return const Center(child: Text(AppStrings.emptyCart));
        }
      },
    ));
  }
}
