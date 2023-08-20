// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:store/core/utils/strings.dart';

import '../../../../constants/images_assets.dart';
import '../../../../constants/text_styles.dart';
import '../../../../core/utils/colors.dart';

class CategoryItemWidget extends StatelessWidget {
  final String name;
  final String image;
  final Function()? onTap;
  const CategoryItemWidget({
    Key? key,
    required this.name,
    required this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.grey.withOpacity(0.3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    image,
                    height: 130,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                name,
                style: subtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
