import 'package:flutter/material.dart';

import 'category_item_widget.dart';

List<String> categoryName = [
  "Electronics",
  "Jewelery",
  "Men's Clothing",
  "Women's Clothing",
];
List<String> categoryImage = [
  "https://www.levalue.my/image/levalue/image/data/Category/GfvkqPSI1572417622.jpg",
  "https://www.mexatk.com/wp-content/uploads/2015/09/%D9%85%D8%AC%D9%88%D9%87%D8%B1%D8%A7%D8%AA-%D8%B0%D9%87%D8%A8-2.jpg",
  "https://i.pinimg.com/originals/79/1a/b8/791ab846361a914fe6a176523e0a2ae6.jpg",
  "https://trapstar.org/wp-content/uploads/2023/04/different-dresses-on-a-rack-730x487-1.jpg",
];

class CategoryItemsWidget extends StatelessWidget {
  const CategoryItemsWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return SizedBox(
              child: CategoryItemWidget(
                name: categoryName[index],
                image: categoryImage[index],
                onTap: () => Navigator.pushNamed(context, 'categoryProducts',
                    arguments: {
                      'categoryName': categoryName[index].toLowerCase()
                    }),
              ),
            );
          }),
    );
  }
}
