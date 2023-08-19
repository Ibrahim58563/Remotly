import 'package:flutter/material.dart';

import '../widgets/cart_app_bar.dart';
import '../widgets/cart_items_widget.dart';
import '../widgets/search_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: cartAppBar(),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SearchWidget(),
              SizedBox(height: 10),
              CartItemsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
