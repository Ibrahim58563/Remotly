import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:store/features/presentation/views/widgets/product_list_view_item.dart';

import '../../../../constants/images_assets.dart';
import '../../manager/get_all_products_cubit/all_products_cubit.dart';

class HomeProductItems extends StatelessWidget {
  const HomeProductItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<AllProductsCubit, AllProductsState>(
          builder: (context, state) {
            if (state is AllProductsSuccess) {
              return ListView.separated(
                  shrinkWrap: false,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ProductListViewItem(
                      state: state,
                      context: context,
                      index: index,
                    );
                  });
            } else if (state is AllProductsFailure) {
              print(state.failure.toString());
              return Text(state.failure);
            } else {
              print(state);
              return Lottie.asset(Assets.animationsLoading);
            }
          },
        ),
      ),
    );
  }
}
