import 'dart:math';

import 'package:flutter_trip/api/http_client.dart';
import 'package:flutter_trip/model/home_model.dart';

class HomeDao {
  static Future<HomeModel> fetchHome() async {
    try {
      HomeModel homeModel = await HttpClient.instance.getHomeApi().getHome();
      if (Random.secure().nextBool()) {
        homeModel.subNavList = null;
      } else {
        homeModel.localNavList = null;
      }
      return homeModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
