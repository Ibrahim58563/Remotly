import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'https://fakestoreapi.com';
  final Dio dio;

  ApiService(this.dio);
  Future<List<dynamic>> get({required String endPoint}) async {
    var response = await dio.get('$_baseUrl$endPoint');
    // print(response.data);
    return response.data;
  }
}
