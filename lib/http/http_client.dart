import 'package:dio/dio.dart';
import 'package:flutter_trip/http/api/crazy_api.dart';
import 'package:flutter_trip/http/api/trip_api.dart';

class HttpClient {
  static final HttpClient _httpClient = HttpClient._internal();
  final Dio _dio = Dio();

  HttpClient._internal() {
    _dio.options.baseUrl = "https://www.devio.org/";
    _dio.options.sendTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.interceptors.add(LogInterceptor());
  }

  static HttpClient get instance => _httpClient;

  CrazyApi getCrazyApi() {
    return CrazyApi(_dio);
  }

  TripApi getTripApi() {
    return TripApi(_dio);
  }
}
