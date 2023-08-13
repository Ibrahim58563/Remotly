import 'package:flutter/material.dart';

import 'category_item_widget.dart';

class CategoryItemsWidget extends StatelessWidget {
  const CategoryItemsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            return const CategoryItemWidget();
          }),
    );
  }
}
