// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:store/features/presentation/views/widgets/see_more_widget.dart';

import '../../../../constants/text_styles.dart';

class SubTitleWidget extends StatelessWidget {
  final String subTitle;
  final Function()? onTap;
  const SubTitleWidget({
    Key? key,
    required this.subTitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          subTitle,
          style: mainTitle,
        ),
        InkWell(onTap: onTap, child: const SeeMoreWidget()),
      ],
    );
  }
}
