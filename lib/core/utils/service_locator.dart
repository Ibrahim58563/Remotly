import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../repo/home_repo_implementation.dart';
import 'api_service.dart';

final getIt = GetIt.instance;
void setup() {
  getIt.registerSingleton<ApiService>(
    ApiService(
      Dio(),
    ),
  );
  getIt.registerSingleton<HomeRepoImplementation>(
    HomeRepoImplementation(
      getIt.get<ApiService>(),
    ),
  );
}

class AuthRepo {
  final ApiService apiService;

  AuthRepo(this.apiService);
}
