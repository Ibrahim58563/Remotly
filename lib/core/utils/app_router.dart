import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store/core/utils/strings.dart';
import 'package:store/features/presentation/views/screens/all_products_screen.dart';
import 'package:store/features/presentation/views/screens/cart_screen.dart';
import 'package:store/features/presentation/views/screens/category_products_screen.dart';
import 'package:store/features/presentation/views/screens/home_screen.dart';
import 'package:store/features/presentation/views/screens/product_details_screen.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomeScreen(),
    AppStrings.cartRouter: (context) => const CartScreen(),
    AppStrings.allProductsRouter: (context) => const AllProductsScreen(),
    '/details': (context) => const ProductDetailsScreen(),
    'categoryProducts': (context) => const CategoryProductsScreen(),
  };
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppStrings.cartRouter:
        PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(seconds: 1),
            settings: routeSettings,
            child: const CartScreen());
      case AppStrings.allProductsRouter:
        PageTransition(
            type: PageTransitionType.rotate,
            alignment: Alignment.center,
            settings: routeSettings,
            duration: const Duration(seconds: 1),
            child: const AllProductsScreen());
      // case '/categoryProducts':
      //   PageTransition(
      //       type: PageTransitionType.rightToLeftWithFade,
      //       alignment: Alignment.center,
      //       settings: routeSettings,
      //       duration: const Duration(seconds: 1),
      //       child: const CategoryProductsScreen());
    }
    return null;
  }
}
