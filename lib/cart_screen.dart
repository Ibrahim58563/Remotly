import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store/constants/images_assets.dart';
import 'package:store/constants/text_styles.dart';
import 'package:store/core/models/cart_model/cart_hive_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: const Text(
              "Cart",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: const Color(0xFFC9CEDA),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Search Product Name',
                        style: greyText.copyWith(fontSize: 20),
                      ),
                      SvgPicture.asset(
                        Assets.imagesCustomizeIcon,
                        height: 30,
                        color: const Color(0xFFA6A798),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
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
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5)),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Center(
                                              child: Image.network(
                                                cartList[index]
                                                    .image
                                                    .toString(),
                                                height: 80,
                                              ),
                                            ),
                                            const CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                CupertinoIcons.heart,
                                                color: Color(0xFFCED55B),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          const Icon(
                                            Icons.star_rounded,
                                            color: Color(0xFFF2C94C),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\$${cartList[index].price.toString()}",
                                            style: subtitle.copyWith(
                                              color: const Color(0xFFBA5C3D),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // context
                                              //     .read<AddToCartCubit>()
                                              //     .addToCart(cartList[index]);
                                              // print("Added from UI");
                                            },
                                            child: const Icon(
                                              CupertinoIcons.cart_badge_plus,
                                              color: Color(0xFFBA5C3D),
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
                    return const Center(child: Text('Empty Cart'));
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
