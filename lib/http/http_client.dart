import 'package:dio/dio.dart';
import 'package:flutter_trip/common/net/interceptors/http_log_interceptors.dart';
import 'package:flutter_trip/http/api/crazy_api.dart';
import 'package:flutter_trip/http/api/trip_api.dart';
import 'package:flutter_trip/utils/timber.dart';

class HttpClient {
  static const String TAG = "DioHttp";
  static final HttpClient _httpClient = HttpClient._internal();
  final Dio _dio = Dio();

  HttpClient._internal() {
    _dio.options.baseUrl = "https://www.devio.org/";
    _dio.options.sendTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.interceptors.add(HttpLogInterceptor(logPrint: (message) {
      Timber.tag(TAG).d(message);
    }));
  }

  static HttpClient get instance => _httpClient;

  CrazyApi getCrazyApi() {
    return CrazyApi(_dio);
  }

  TripApi getTripApi() {
    return TripApi(_dio);
  }
}
