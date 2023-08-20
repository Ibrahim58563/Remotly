import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store/core/repo/home_repo_implementation.dart';
import 'package:store/core/utils/app_router.dart';
import 'package:store/core/utils/service_locator.dart';
import 'package:store/features/presentation/manager/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:store/features/presentation/manager/get_products_by_cateogory/get_products_by_category_cubit.dart';
import 'package:store/features/presentation/views/screens/home_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'core/models/cart_model/cart_hive_model.dart';
import 'features/presentation/manager/get_all_products_cubit/all_products_cubit.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(CartHiveModelAdapter());
  await Hive.openBox<CartHiveModel>('cart');
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(
        Colors.white); // Change this color as needed
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );
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
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
              .copyWith(background: Colors.white),
        ),
        initialRoute: '/',
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
