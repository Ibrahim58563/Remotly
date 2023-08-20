// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:store/core/repo/home_repo_implementation.dart';
import 'package:store/core/utils/service_locator.dart';

import 'package:store/features/presentation/manager/get_products_by_cateogory/get_products_by_category_cubit.dart';
import 'package:store/features/presentation/views/widgets/category_items_widget.dart';

import '../../../../constants/images_assets.dart';
import '../../../../constants/text_styles.dart';
import '../../../../core/utils/colors.dart';
import '../../manager/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../manager/get_all_products_cubit/all_products_cubit.dart';

class CategoryProductsWidget extends StatefulWidget {
  final String categoryName;
  const CategoryProductsWidget({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<CategoryProductsWidget> createState() => _CategoryProductsWidgetState();
}

class _CategoryProductsWidgetState extends State<CategoryProductsWidget>
    with TickerProviderStateMixin {
  List<AnimationController> _animationControllers = [];
  late final AnimationController _controller;
  Future<void> fetchCategoryProducts() async {
    await context
        .read<GetProductsByCategoryCubit>()
        .getCategory(widget.categoryName);
    print("should have fetched ${widget.categoryName}");
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    fetchCategoryProducts();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationControllers.clear();
    super.dispose();
  }

  bool startAnimation = false;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child:
          BlocBuilder<GetProductsByCategoryCubit, GetProductsByCategoryState>(
        builder: (context, state) {
          print(
              "${context.read<GetProductsByCategoryCubit>().categoryName.length} length");
          if (state is GetProductsByCategorySuccess) {
            _animationControllers = List.generate(
                state.categoryProducts.length,
                (index) => AnimationController(
                    vsync: this, duration: const Duration(seconds: 1)));
            return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: state.categoryProducts.length,
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
                                        state.categoryProducts[index].image
                                            .toString(),
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
                                state.categoryProducts[index].title
                                    .toString(),
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
                                    "Rating: ${state.categoryProducts[index].rating!.rate}  "
                                        .toString(),
                                    style: greyText,
                                  ),
                                  Icon(
                                    Icons.star_rounded,
                                    color: AppColors.orange,
                                  ),
                                  Text(
                                    "  Count: ${state.categoryProducts[index].rating!.count}"
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
                                    "\$${state.categoryProducts[index].price.toString()}",
                                    style: subtitle.copyWith(
                                      color: AppColors.darkOrange,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context
                                          .read<AddToCartCubit>()
                                          .addToCart(
                                              state.categoryProducts[index]);
                                      if (_animationControllers[index]
                                          .isDismissed) {
                                        _animationControllers[index]
                                            .forward();
                                        startAnimation = true;
                                      } else {
                                        _animationControllers[index]
                                            .reverse();
                                        startAnimation = false;
                                      }
                                    },
                                    child: Lottie.asset(
                                      Assets.animationsCart,
                                      height: 40,
                                      controller:
                                          _animationControllers[index],
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
          } else if (state is AllProductSearchSuccess) {
            return const Center(
              child: Text("Search Should be here"),
            );
            // return ListView.separated(
            //     separatorBuilder: (context, index) => const SizedBox(
            //           height: 10,
            //         ),
            //     itemCount: state.filteredProducts.length,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         height: 130,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(8),
            //           border:
            //               Border.all(color: AppColors.grey.withOpacity(0.5)),
            //         ),
            //         child: Row(
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Container(
            //                 width: 100,
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(12),
            //                   color: AppColors.grey.withOpacity(0.2),
            //                 ),
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Stack(
            //                       alignment: Alignment.topRight,
            //                       children: [
            //                         Center(
            //                           child: Image.network(
            //                             state.filteredProducts[index].image
            //                                 .toString(),
            //                             height: 80,
            //                           ),
            //                         ),
            //                         CircleAvatar(
            //                           backgroundColor: AppColors.white,
            //                           child: Icon(
            //                             CupertinoIcons.heart,
            //                             color: AppColors.yellow,
            //                           ),
            //                         ),
            //                       ]),
            //                 ),
            //               ),
            //             ),
            //             SizedBox(
            //               width: MediaQuery.of(context).size.width * 0.5,
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   const SizedBox(
            //                     height: 10,
            //                   ),
            //                   Text(
            //                     state.filteredProducts[index].title.toString(),
            //                     style: subtitle,
            //                     softWrap: true,
            //                     overflow: TextOverflow.ellipsis,
            //                     maxLines: 1,
            //                   ),
            //                   const SizedBox(
            //                     height: 5,
            //                   ),
            //                   Row(
            //                     children: [
            //                       Text(
            //                         "Rating: ${state.filteredProducts[index].rating!.rate}  "
            //                             .toString(),
            //                         style: greyText,
            //                       ),
            //                       Icon(
            //                         Icons.star_rounded,
            //                         color: AppColors.orange,
            //                       ),
            //                       Text(
            //                         "  Count: ${state.filteredProducts[index].rating!.count}"
            //                             .toString(),
            //                         style: greyText,
            //                       ),
            //                     ],
            //                   ),
            //                   const SizedBox(
            //                     height: 20,
            //                   ),
            //                   Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Text(
            //                         "\$${state.filteredProducts[index].price.toString()}",
            //                         style: subtitle.copyWith(
            //                           color: AppColors.darkOrange,
            //                         ),
            //                       ),
            //                       InkWell(
            //                         onTap: () {
            //                           context.read<AddToCartCubit>().addToCart(
            //                               state.filteredProducts[index]);
            //                           if (_animationControllers[index]
            //                               .isDismissed) {
            //                             _animationControllers[index].forward();
            //                             startAnimation = true;
            //                           } else {
            //                             _animationControllers[index].reverse();
            //                             startAnimation = false;
            //                           }
            //                         },
            //                         child: Lottie.asset(
            //                           Assets.animationsCart,
            //                           height: 40,
            //                           controller: _animationControllers[index],
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             )
            //           ],
            //         ),
            //       );
            //     });
          } else if (state is GetProductsByCategoryFailure) {
            print(state.errMessage.toString());
            return Text(state.errMessage);
          } else {
            print(state);
            return Lottie.asset(Assets.animationsLoading);
          }
        },
      ),
    );
  }
}
