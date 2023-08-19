// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:store/constants/text_styles.dart';
import 'package:store/core/utils/strings.dart';
import 'package:store/features/presentation/views/widgets/workspace_title_widget.dart';
import '../widgets/category_items_widget.dart';
import '../widgets/home_product_items.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/main_floating_action_button.dart';
import '../widgets/special_offer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: const MainFloatingActionsButton(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const MainAppBar(),
            const SizedBox(height: 10),
            const Text(
              AppStrings.popular,
              style: mainTitle,
            ),
            const SpecialOfferWidget(),
            const SizedBox(height: 10),
            Container(
                child: const SubTitleWidget(subTitle: AppStrings.workspaces)),
            const SizedBox(height: 10),
            const CategoryItemsWidget(),
            SubTitleWidget(
              subTitle: AppStrings.arrival,
              onTap: () => Navigator.pushNamed(
                  context, AppStrings.allProductsRouter,
                  arguments: AppStrings.argument),
            ),
            const SizedBox(height: 10),
            const HomeProductItems(),
          ]),
        ),
      ),
    );
  }
}
