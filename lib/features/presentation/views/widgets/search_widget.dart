import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/core/utils/colors.dart';
import 'package:store/core/utils/strings.dart';

import '../../../../constants/images_assets.dart';
import '../../../../constants/text_styles.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.lightGrey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.search,
              style: greyText.copyWith(fontSize: 20),
            ),
            SvgPicture.asset(
              Assets.imagesCustomizeIcon,
              height: 30,
              color: AppColors.darkYellow,
            )
          ],
        ),
      ),
    );
  }
}
