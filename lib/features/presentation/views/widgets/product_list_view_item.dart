import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/images_assets.dart';
import '../../../../constants/text_styles.dart';
import '../../../../core/utils/colors.dart';
import '../../manager/add_to_cart_cubit/add_to_cart_cubit.dart';

class ProductListViewItem extends StatefulWidget {
  dynamic state;
  int index;
  BuildContext context;
  ProductListViewItem({
    Key? key,
    required this.state,
    required this.index,
    required this.context,
  }) : super(key: key);

  @override
  State<ProductListViewItem> createState() => _ProductListViewItemState();
}

class _ProductListViewItemState extends State<ProductListViewItem>
    with TickerProviderStateMixin {
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
                child: Stack(alignment: Alignment.topRight, children: [
                  Center(
                    child: Image.network(
                      widget.state.products[widget.index].image.toString(),
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
                  widget.state.products[widget.index].title.toString(),
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
                      "Rating: ${widget.state.products[widget.index].rating!.rate}  "
                          .toString(),
                      style: greyText,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: AppColors.orange,
                    ),
                    Text(
                      "  Count: ${widget.state.products[widget.index].rating!.count}"
                          .toString(),
                      style: greyText,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${widget.state.products[widget.index].price.toString()}",
                      style: subtitle.copyWith(
                        color: AppColors.darkOrange,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context
                            .read<AddToCartCubit>()
                            .addToCart(widget.state.products[widget.index]);
                        if (!startAnimation) {
                          _animationControllers[widget.index].forward();
                          startAnimation = true;
                        } else {
                          _animationControllers[widget.index].reverse();
                          startAnimation = false;
                        }
                      },
                      child: Lottie.asset(
                        Assets.animationsCart,
                        height: 40,
                        controller: _animationControllers[widget.index],
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
  }
}
