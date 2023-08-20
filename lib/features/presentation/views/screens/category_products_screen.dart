import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/repo/home_repo_implementation.dart';
import 'package:store/core/utils/capitalize_extension.dart';
import 'package:store/core/utils/service_locator.dart';
import 'package:store/features/presentation/manager/get_products_by_cateogory/get_products_by_category_cubit.dart';
import 'package:store/features/presentation/views/widgets/category_products_widget.dart';
import 'package:store/features/presentation/views/widgets/search_widget.dart';
import '../widgets/all_product_search_widget.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({super.key});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String categoryName = arguments?['categoryName'];

    return SafeArea(
      child: BlocProvider(
        create: (context) => GetProductsByCategoryCubit(
          getIt.get<HomeRepoImplementation>(),
          categoryName.toLowerCase(), // Pass the selected category name
        ),
        child: Scaffold(
          appBar: allProductSearchWidget(categoryName.capitalize()),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SearchWidget(),
                const SizedBox(height: 10),
                CategoryProductsWidget(
                  categoryName: categoryName,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
