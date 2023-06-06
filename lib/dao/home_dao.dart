import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_trip/model/home_model.dart';

const HOME_URL = "https://www.devio.org/io/flutter_app/json/home_page.json";

class HomeDao {
  static final Dio dio = Dio();

  static Future<HomeModel> fetch() async {
    final response = await dio.get(HOME_URL);
    if (response.statusCode == 200) {
      return HomeModel.fromJson(response.data);
    }
    return Future.error("Failed to load home_page.json");
  }
}
