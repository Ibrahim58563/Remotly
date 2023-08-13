import 'package:flutter/material.dart';
import 'package:store/core/utils/strings.dart';

AppBar allProductSearchWidget() {
  return AppBar(
      elevation: 0,
      title: Text(
        AppStrings.allProducts,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ));
}
