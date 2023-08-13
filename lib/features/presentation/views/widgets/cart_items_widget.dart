import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store/core/utils/strings.dart';

import '../../../../constants/text_styles.dart';
import '../../../../core/models/cart_model/cart_hive_model.dart';
import '../../../../core/utils/colors.dart';

class CartItemsWidget extends StatelessWidget {
  const CartItemsWidget({super.key});

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
                                child: Image.network(
                                  cartList[index].image.toString(),
                                  height: 80,
                                ),
                              ),
                               CircleAvatar(
                                backgroundColor: AppColors.white,
                                child: Icon(
                                  CupertinoIcons.heart,
                                  color: AppColors.yellow,
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
                                    color:  AppColors.darkOrange,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // context
                                    //     .read<AddToCartCubit>()
                                    //     .addToCart(cartList[index]);
                                    // print("Added from UI");
                                  },
                                  child:  Icon(
                                    CupertinoIcons.cart_badge_plus,
                                    color: AppColors.darkOrange,
                                  ),
                                )
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
          return Center(child: Text(AppStrings.emptyCart));
        }
      },
    ));
  }
}
