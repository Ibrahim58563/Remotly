import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout');

      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            statusCode: dioError.response!.statusCode!);

      case DioExceptionType.cancel:
        return ServerFailure('Your request was canceled');

      case DioExceptionType.connectionError:
        return ServerFailure('Connection Error');

      case DioExceptionType.unknown:
        return ServerFailure('Unknown Error');
    }
  }

  factory ServerFailure.fromResponse(
      {required int statusCode, dynamic response}) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request Not Found, try again later');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server Error, try Later');
    } else {
      return ServerFailure('Error, Try Again later');
    }
  }
}
