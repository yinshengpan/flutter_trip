import 'package:flutter_trip/http/http_client.dart';
import 'package:flutter_trip/http/model/search_model.dart';

class TripDao {
  static Future<SearchModel> doSearch(String? keyword) async {
    try {
      SearchModel model =
          await HttpClient.instance.getTripApi().doSearch(keyword);
      model.keyword = keyword;
      return model;
    } catch (e) {
      return Future.error(e);
    }
  }
}
