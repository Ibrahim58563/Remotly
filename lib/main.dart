import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/repo/home_repo_implementation.dart';
import 'package:store/core/utils/service_locator.dart';
import 'package:store/features/presentation/manager/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:store/home_screen.dart';

import 'features/presentation/manager/get_all_products_cubit/all_products_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AllProductsCubit(getIt.get<HomeRepoImplementation>())
                ..fetchAllProducts(),
        ),
        BlocProvider(
          create: (context) => AddToCartCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
