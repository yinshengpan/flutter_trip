import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/search_view.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
        ],
      ),
    );
  }

  void _onTextChanged(String text) {
    print(text);
  }
}
