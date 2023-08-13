import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:store/constants/images_assets.dart';
import 'package:store/constants/text_styles.dart';
import 'package:store/features/presentation/views/widgets/all_products_widget.dart';
import 'package:store/features/presentation/views/widgets/search_widget.dart';

import '../../manager/add_to_cart_cubit/add_to_cart_cubit.dart';
import '../../manager/get_all_products_cubit/all_products_cubit.dart';
import '../widgets/all_product_search_widget.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: allProductSearchWidget(),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SearchWidget(),
              SizedBox(height: 10),
              AllProductsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
