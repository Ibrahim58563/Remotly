import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../constants/images_assets.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/strings.dart';
import '../screens/cart_screen.dart';

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
              backgroundColor: AppColors.offWhite,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.white,
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
                Navigator.pushNamed(context, AppStrings.cartRouter,
                    arguments: AppStrings.argument);
              },
              child: CircleAvatar(
                radius: 25.5,
                backgroundColor: AppColors.offWhite,
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.white,
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
