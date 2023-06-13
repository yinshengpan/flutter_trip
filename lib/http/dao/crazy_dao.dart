import 'package:flutter_trip/http/http_client.dart';
import 'package:flutter_trip/http/model/home_model.dart';

class CrazyDao {
  static Future<HomeModel> fetchHome() async {
    try {
      return await HttpClient.instance.getCrazyApi().getHome();
    } catch (e) {
      return Future.error(e);
    }
  }
}
