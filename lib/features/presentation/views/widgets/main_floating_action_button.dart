import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/strings.dart';

class MainFloatingActionsButton extends StatelessWidget {
  const MainFloatingActionsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, AppStrings.cartRouter,
            arguments: AppStrings.argument);
      },
      backgroundColor: AppColors.black,
      child: Icon(
        CupertinoIcons.cart,
        color: AppColors.white,
      ),
    );
  }
}
