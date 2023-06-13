import 'package:dio/dio.dart';
import 'package:flutter_trip/http/model/home_model.dart';
import 'package:retrofit/http.dart';

part 'crazy_api.g.dart';

@RestApi()
abstract class CrazyApi {
  factory CrazyApi(Dio dio, {String baseUrl}) = _CrazyApi;

  @GET("/io/flutter_app/json/home_page.json")
  Future<HomeModel> getHome();
}
