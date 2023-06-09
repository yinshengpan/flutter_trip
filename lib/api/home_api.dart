import 'package:dio/dio.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:retrofit/http.dart';

part 'home_api.g.dart';

@RestApi()
abstract class HomeApi {
  factory HomeApi(Dio dio, {String baseUrl}) = _HomeApi;

  @GET("/io/flutter_app/json/home_page.json")
  Future<HomeModel> getHome();
}
