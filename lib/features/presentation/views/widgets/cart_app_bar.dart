import 'package:flutter/material.dart';
import 'package:store/core/utils/strings.dart';

AppBar cartAppBar() {
  return AppBar(
      elevation: 0,
      title: Text(
        AppStrings.cart,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ));
}
