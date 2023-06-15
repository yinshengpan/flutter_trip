import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

/// [HttpLogInterceptor] is used to print logs during network requests.
/// It's better to add [HttpLogInterceptor] to the tail of the interceptor queue,
/// otherwise the changes made in the interceptor behind A will not be printed out.
/// This is because the execution of interceptors is in the order of addition.
class HttpLogInterceptor extends Interceptor {
  HttpLogInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseHeader = true,
    this.responseBody = true,
    this.error = true,
    this.logPrint = _debugPrint,
  });

  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.data]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  int _requestStartTime = 0;

  /// Log printer; defaults print log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file, for example:
  ///```dart
  ///  final file=File("./log.txt");
  ///  final sink=file.openWrite();
  ///  dio.interceptors.add(LogInterceptor(logPrint: sink.writeln));
  ///  ...
  ///  await sink.close();
  ///```
  void Function(Object object) logPrint;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    logPrint('——> ${options.method} ${options.uri}');
    _requestStartTime = DateTime.now().millisecondsSinceEpoch;
    if (request) {
      _printKV('responseType', options.responseType.toString());
      _printKV('followRedirects', options.followRedirects);
      _printKV('persistentConnection', options.persistentConnection);
      _printKV('connectTimeout', options.connectTimeout);
      _printKV('sendTimeout', options.sendTimeout);
      _printKV('receiveTimeout', options.receiveTimeout);
      _printKV(
        'receiveDataWhenStatusError',
        options.receiveDataWhenStatusError,
      );
      if (options.extra.isNotEmpty) {
        _printKV('extra', options.extra);
      }
    }
    if (requestHeader && options.headers.isNotEmpty) {
      logPrint('headers:');
      options.headers.forEach((key, v) => _printKV(' $key', v));
    }
    if (requestBody && options.data != null) {
      logPrint('data:');
      _printAll(options.data);
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    _printResponse(response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (error) {
      if (err.response != null) {
        _printResponse(err.response!);
      } else {
        logPrint('<—— Exception ${err.requestOptions.uri}${_getRequestTime()}');
        logPrint('$err');
        logPrint("<—— END HTTP ");
      }
    }
    handler.next(err);
  }

  void _printResponse(Response response) {
    String url = response.requestOptions.uri.toString();
    logPrint('<—— ${response.statusCode} $url${_getRequestTime()}');
    if (responseHeader) {
      if (response.isRedirect == true) {
        _printKV('redirect', response.realUri);
      }

      logPrint('headers:');
      response.headers.forEach((key, v) => _printKV(' $key', v.join('\r\n\t')));
    }
    String result = response.toString();
    if (responseBody) {
      logPrint('');
      _printAll(result);
    }
    logPrint("<—— END HTTP (${utf8.encode(result).length}-byte body)");
  }

  void _printKV(String key, Object? v) {
    logPrint('$key: $v');
  }

  void _printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }

  String _getRequestTime() {
    int requestTime = DateTime.now().millisecondsSinceEpoch - _requestStartTime;
    return "(${requestTime}ms)";
  }
}

void _debugPrint(Object? object) {
  assert(() {
    debugPrint(object?.toString());
    return true;
  }());
}
