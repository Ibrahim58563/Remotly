import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/images_assets.dart';
import '../../../../constants/text_styles.dart';
import '../../../../core/utils/colors.dart';
import '../../manager/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../manager/get_all_products_cubit/all_products_cubit.dart';

class AllProductsWidget extends StatefulWidget {
  const AllProductsWidget({super.key});

  @override
  State<AllProductsWidget> createState() => _AllProductsWidgetState();
}

class _AllProductsWidgetState extends State<AllProductsWidget>
    with TickerProviderStateMixin {
  List<AnimationController> _animationControllers = [];
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  bool startAnimation = false;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocBuilder<AllProductsCubit, AllProductsState>(
        builder: (context, state) {
          if (state is AllProductsSuccess) {
            _animationControllers = List.generate(
                state.products.length,
                (index) => AnimationController(
                    vsync: this, duration: const Duration(seconds: 1)));
            return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: AppColors.grey.withOpacity(0.5)),
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
                              child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Center(
                                      child: Image.network(
                                        state.products[index].image.toString(),
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
                                state.products[index].title.toString(),
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
                                    "Rating: ${state.products[index].rating!.rate}  "
                                        .toString(),
                                    style: greyText,
                                  ),
                                   Icon(
                                    Icons.star_rounded,
                                    color: AppColors.orange,
                                  ),
                                  Text(
                                    "  Count: ${state.products[index].rating!.count}"
                                        .toString(),
                                    style: greyText,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${state.products[index].price.toString()}",
                                    style: subtitle.copyWith(
                                      color:  AppColors.darkOrange,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context
                                          .read<AddToCartCubit>()
                                          .addToCart(state.products[index]);
                                      if (_animationControllers[index]
                                          .isDismissed) {
                                        _animationControllers[index].forward();
                                        startAnimation = true;
                                      } else {
                                        _animationControllers[index].reverse();
                                        startAnimation = false;
                                      }
                                    },
                                    child: Lottie.asset(
                                      Assets.animationsCart,
                                      height: 40,
                                      controller: _animationControllers[index],
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
          } else if (state is AllProductsFailure) {
            print(state.failure.toString());
            return Text(state.failure);
          } else {
            print(state);
            return Lottie.asset(Assets.animationsLoading);
          }
        },
      ),
    );
  }
}
