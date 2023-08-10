import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store/all_products_screen.dart';
import 'package:store/cart_screen.dart';
import 'package:store/constants/images_assets.dart';
import 'package:store/constants/text_styles.dart';
import 'package:store/features/presentation/manager/add_to_cart_cubit/add_to_cart_cubit.dart';

import 'features/presentation/manager/get_all_products_cubit/all_products_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<AnimationController> _animationControllers = [];
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    for (int i = 0; i < 3; i++) {
      _animationControllers.add(AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool startAnimation = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    duration: const Duration(seconds: 1),
                    child: const CartScreen()));
          },
          backgroundColor: Colors.black,
          child: const Icon(
            CupertinoIcons.cart,
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const MainAppBar(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Popular now',
              style: mainTitle,
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Adjustable Office \nChair',
                          style: mainTitle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Hughlan Workspaces *',
                              style: greyText,
                            ),
                            Text(
                              '4.8',
                              style: greyText.copyWith(color: Colors.white),
                            ),
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFF2C94C),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFCED55B),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 12),
                                child: Text(
                                  'View Item',
                                  style: subtitle,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              backgroundColor: const Color(0x33A6A798),
                              child: SvgPicture.asset(
                                Assets.imagesCartIcon,
                                color: const Color(0xFFA6A798),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Image.asset(
                    Assets.imagesChair,
                    height: 240,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Workspaces',
                  style: mainTitle,
                ),
                SeeMoreWidget(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                Assets.imagesStudio,
                                height: 105,
                              ),
                            ),
                          ),
                          const Text(
                            'Photographer',
                            style: subtitle,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'New arrivals',
                  style: mainTitle,
                ),
                SeeMoreWidget(onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rotate,
                          alignment: Alignment.center,
                          duration: const Duration(seconds: 1),
                          child: const AllProductsScreen()));
                }),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: BlocBuilder<AllProductsCubit, AllProductsState>(
                builder: (context, state) {
                  if (state is AllProductsSuccess) {
                    return ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: 3,
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
                                              if (!startAnimation) {
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
          ]),
        ),
      ),
    );
  }
}

class SeeMoreWidget extends StatelessWidget {
  final Function()? onTap;
  const SeeMoreWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: const Row(
        children: [
          Text(
            'See more',
            style: greyText,
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.keyboard_arrow_right_rounded,
            color: Color(0xFF8A8B7A),
          ),
        ],
      ),
    );
  }
}

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              Assets.imagesCircleAvatarImage,
              height: 50,
            )),
        Row(
          children: [
            CircleAvatar(
              radius: 25.5,
              backgroundColor: const Color(0xFFDDDDDB),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  Assets.imagesSearchIcon,
                  height: 35,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(seconds: 1),
                        child: const CartScreen()));
              },
              child: CircleAvatar(
                radius: 25.5,
                backgroundColor: const Color(0xFFDDDDDB),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                    Assets.imagesCartIcon,
                    height: 35,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
