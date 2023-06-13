import 'package:dio/dio.dart';
import 'package:flutter_trip/http/model/search_model.dart';
import 'package:retrofit/http.dart';

part 'trip_api.g.dart';

@RestApi(baseUrl: "https://m.ctrip.com/restapi/h5api/")
abstract class TripApi {
  factory TripApi(Dio dio, {String baseUrl}) = _TripApi;

  @GET(
      "/globalsearch/search?source=mobileweb&action=autocomplete&contentType=json")
  Future<SearchModel> doSearch(@Query("keyword") String? keyword);
}
