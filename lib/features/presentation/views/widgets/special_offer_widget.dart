import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/core/utils/strings.dart';

import '../../../../constants/images_assets.dart';
import '../../../../constants/text_styles.dart';
import '../../../../core/utils/colors.dart';

class SpecialOfferWidget extends StatelessWidget {
  const SpecialOfferWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppColors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    AppStrings.adjustable,
                    style: mainTitle.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      AppStrings.vendor,
                      style: greyText,
                    ),
                    Text(
                      AppStrings.rating,
                      style: greyText.copyWith(color: AppColors.white),
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
                Row(
                  children: [
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, '/details', arguments: {
                        'title': AppStrings.adjustable,
                        'vendor': AppStrings.vendor,
                        'rating': AppStrings.rating,
                        'image': Assets.imagesChair,
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22, vertical: 12),
                          child: Text(
                            AppStrings.view,
                            style: subtitle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.darkGrey,
                      child: SvgPicture.asset(
                        Assets.imagesCartIcon,
                        color: AppColors.darkYellow,
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
    );
  }
}
