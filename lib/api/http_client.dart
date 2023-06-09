import 'package:dio/dio.dart';
import 'package:flutter_trip/api/home_api.dart';

class HttpClient {
  static final HttpClient _httpClient = HttpClient._internal();
  final Dio _dio = Dio();

  factory HttpClient() {
    return _httpClient;
  }

  HttpClient._internal() {
    _dio.options.baseUrl = "https://www.devio.org/";
    _dio.options.sendTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.interceptors.add(LogInterceptor());
  }

  static HttpClient get instance => HttpClient();

  HomeApi getHomeApi() {
    return HomeApi(_dio);
  }
}
