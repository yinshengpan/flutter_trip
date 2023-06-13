import 'package:flutter/material.dart';
import 'package:flutter_trip/http/dao/trip_dao.dart';
import 'package:flutter_trip/http/model/search_model.dart';
import 'package:flutter_trip/widget/search_view.dart';

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String defaultText;
  final String hint;
  final String keyword;

  const SearchPage(
      {super.key,
      this.hideLeft = false,
      this.keyword = "",
      this.defaultText = "",
      this.hint = ""});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _keyword = "";
  SearchModel? _searchModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _createAppBar(context),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: _searchModel?.data?.length ?? 0,
                itemBuilder: (context, position) {
                  return _createItem(context, position);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _createAppBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.only(bottom: 6),
      child: SafeArea(
        child: Column(
          children: [
            SearchView(
              hideLeft: widget.hideLeft,
              defaultText: widget.defaultText,
              hint: widget.hint,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChanged,
            )
          ],
        ),
      ),
    );
  }

  void _onTextChanged(String text) {
    _keyword = text;
    if (_keyword.isEmpty) {
      setState(() {
        _searchModel = null;
      });
      return;
    }
    TripDao.doSearch(_keyword).then((value) {
      setState(() {
        if (_keyword == value.keyword) {
          _searchModel = value;
        }
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  Widget? _createItem(BuildContext context, int position) {
    if (_searchModel?.data?.isEmpty ?? true) {
      return null;
    }
    SearchItem item = _searchModel!.data![position];
    return GestureDetector(
      onTap: () {},
      child: Text(item.word ?? ""),
    );
  }
}
