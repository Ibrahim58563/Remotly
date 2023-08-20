import 'package:flutter/material.dart';
import 'package:store/core/utils/strings.dart';

AppBar allProductSearchWidget(String title) {
  return AppBar(
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ));
}
