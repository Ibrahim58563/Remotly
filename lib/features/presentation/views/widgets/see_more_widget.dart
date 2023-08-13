import 'package:flutter/material.dart';
import 'package:store/core/utils/colors.dart';
import 'package:store/core/utils/strings.dart';

import '../../../../constants/text_styles.dart';

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
      child: Row(
        children: [
          Text(
            AppStrings.seeMore,
            style: greyText,
          ),
          const SizedBox(
            width: 5,
          ),
           Icon(
            Icons.keyboard_arrow_right_rounded,
            color:AppColors.strangeYellow,
          ),
        ],
      ),
    );
  }
}
