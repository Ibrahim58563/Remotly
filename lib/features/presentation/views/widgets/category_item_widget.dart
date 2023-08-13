import 'package:flutter/material.dart';
import 'package:store/core/utils/strings.dart';

import '../../../../constants/images_assets.dart';
import '../../../../constants/text_styles.dart';
import '../../../../core/utils/colors.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.grey.withOpacity(0.3),
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
          Text(
            AppStrings.photographer,
            style: subtitle,
          ),
        ],
      ),
    );
  }
}
