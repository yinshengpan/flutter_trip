import 'package:dio/dio.dart';
import 'package:flutter_trip/utils/timber.dart';

class HttpLogInterceptors extends InterceptorsWrapper {
  static const String TAG = "DioHttp";
  static List<Map?> sHttpResponses = [];
  static List<String?> sResponsesHttpUrl = [];

  static List<Map<String, dynamic>?> sHttpRequest = [];
  static List<String?> sRequestHttpUrl = [];

  static List<Map<String, dynamic>?> sHttpError = [];
  static List<String?> sHttpErrorUrl = [];

  @override
  onRequest(RequestOptions options, handler) async {
    Timber.tag(TAG).d("请求url：${options.path} ${options.method}");
    options.headers.forEach((k, v) => options.headers[k] = v ?? "");
    Timber.tag(TAG).d('请求头: ${options.headers}');
    if (options.data != null) {
      Timber.tag(TAG).d('请求参数: ${options.data}');
    }
    try {
      addLogic(sRequestHttpUrl, options.path);
      var data;
      if (options.data is Map) {
        data = options.data;
      } else {
        data = Map<String, dynamic>();
      }
      var map = {
        "header:": {...options.headers},
      };
      if (options.method == "POST") {
        map["data"] = data;
      }
      addLogic(sHttpRequest, map);
    } catch (e) {
      Timber.tag(TAG).e(e);
    }
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, handler) async {
    Timber.tag(TAG).d('返回参数: $response');
    switch (response.data) {
      case Map || List:
        {
          try {
            var data = Map<String, dynamic>();
            data["data"] = response.data;
            addLogic(sResponsesHttpUrl, response.requestOptions.uri.toString());
            addLogic(sHttpResponses, data);
          } catch (e) {
            print(e);
          }
        }
      case String:
        {
          try {
            var data = Map<String, dynamic>();
            data["data"] = response.data;
            addLogic(sResponsesHttpUrl, response.requestOptions.uri.toString());
            addLogic(sHttpResponses, data);
          } catch (e) {
            print(e);
          }
        }
    }
    return super.onResponse(response, handler);
  }

  @override
  onError(DioError err, handler) async {
    Timber.tag(TAG).d('请求异常: $err');
    Timber.tag(TAG).d('请求异常信息: ${err.response?.toString() ?? ""}');
    try {
      addLogic(sHttpErrorUrl, err.requestOptions.path);
      var errors = Map<String, dynamic>();
      errors["error"] = err.message;
      addLogic(sHttpError, errors);
    } catch (e) {
      print(e);
    }
    return super.onError(err, handler);
  }

  static addLogic(List list, data) {
    if (list.length > 20) {
      list.removeAt(0);
    }
    list.add(data);
  }
}
