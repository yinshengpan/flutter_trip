import 'package:flutter/material.dart';
import 'package:flutter_trip/http/dao/trip_dao.dart';
import 'package:flutter_trip/widget/search_view.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _showText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("搜索"),
      ),
      body: Column(
        children: [
          SearchView(
            hideLeft: true,
            defaultText: "哈哈",
            hint: "123",
            leftButtonClick: () {
              Navigator.pop(context);
            },
            onChanged: _onTextChanged,
          ),
          InkWell(
            onTap: () {
              TripDao.doSearch("长城").then((value) {
                setState(() {
                  _showText = value.toJson().toString();
                });
              }).onError((error, stackTrace) {});
            },
            child: Text("Get"),
          ),
          Text(_showText),
        ],
      ),
    );
  }

  void _onTextChanged(String text) {
    print(text);
  }
}
