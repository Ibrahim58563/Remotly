import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:store/constants/images_assets.dart';
import 'package:store/constants/text_styles.dart';

import 'features/presentation/manager/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'features/presentation/manager/get_all_products_cubit/all_products_cubit.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen>
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: const Text(
              "All Products",
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
              Flexible(
                child: BlocBuilder<AllProductsCubit, AllProductsState>(
                  builder: (context, state) {
                    if (state is AllProductsSuccess) {
                      _animationControllers = List.generate(
                          state.products.length,
                          (index) => AnimationController(
                              vsync: this,
                              duration: const Duration(seconds: 1)));
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
                                                  state.products[index].image
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
                                          state.products[index].title
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
                                              "Rating: ${state.products[index].rating!.rate}  "
                                                  .toString(),
                                              style: greyText,
                                            ),
                                            const Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFFF2C94C),
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
                                                color: const Color(0xFFBA5C3D),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                context
                                                    .read<AddToCartCubit>()
                                                    .addToCart(
                                                        state.products[index]);
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
                                                    _animationControllers[
                                                        index],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
