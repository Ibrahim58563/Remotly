import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/constants/images_assets.dart';
import 'package:store/core/models/product/product_model.dart';
import 'package:store/core/utils/strings.dart';

import '../../../../constants/text_styles.dart';
import '../../../../core/utils/colors.dart';
import '../../manager/add_to_cart_cubit/add_to_cart_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String title = arguments?['title'];
    final String vendor = arguments?['vendor'];
    final String rating = arguments?['rating'];
    final String image = arguments?['image'];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: Column(children: [
          Container(
            color: AppColors.lightGrey.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                image,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: mainTitle,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      vendor,
                      style: greyText,
                    ),
                    Text(
                      rating,
                      // style: greyText,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: AppColors.orange,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: AppColors.orange,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: AppColors.orange,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: AppColors.orange,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Hughlan ergonomic chair adopts an ergonomic design.This ergonomic desk chair can help you ease fatigue, reduce occupational disesase and let you develop good sitting posture habits',
                  style: normalText,
                ),
                BlocListener<AddToCartCubit, AddToCartState>(
                  listener: (context, state) {},
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: InkWell(
                      onTap: () {
                        final ProductModel product = ProductModel.fromJson({
                          'id': 0000,
                          'title': arguments?['title'],
                          'vendor': arguments?['vendor'],
                          'rating': const {
                            'rate': 4.9,
                            'count': 435,
                          },
                          'description': AppStrings.specialOfferDescription,
                          'image': Assets.imagesChair,
                          'price': 358,
                        });
                        context.read<AddToCartCubit>().addToCart(product);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22, vertical: 12),
                          child: Center(
                            child: Text(
                              AppStrings.addToCart,
                              style: subtitle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
