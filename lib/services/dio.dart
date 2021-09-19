import 'package:dio/dio.dart';

Dio dio() {
  BaseOptions options = BaseOptions(
      baseUrl: 'http://127.0.0.1:8000/api/',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {'Accept': 'application/json'});

  Dio dio = Dio(options);
  return dio;
}
