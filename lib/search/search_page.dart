import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/http/dao/trip_dao.dart';
import 'package:flutter_trip/http/model/search_model.dart';
import 'package:flutter_trip/widget/search_view.dart';
import 'package:flutter_trip/widget/webview.dart';

const List<String> _typeList = [
  "channelgroup",
  "channelgs",
  "channelplane",
  "channeltrain",
  "cruise",
  "district",
  "food",
  "hotel",
  "huodong",
  "shop",
  "sight",
  "ticket",
  "travelgroup",
];

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
        bottom: false,
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
      onTap: () {
        Navigator.push(context,
            CupertinoModalPopupRoute(builder: (BuildContext context) {
          return WebView(
            url: item.url ?? "",
            title: '详情',
          );
        }));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.3,
              color: Colors.grey,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(1),
              child: Image.asset(
                _getTypeImage(item.type),
                width: 26,
                height: 26,
              ),
            ),
            Column(
              children: [
                _title(item),
                _subTitle(item),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getTypeImage(String? type) {
    for (var value in _typeList) {
      if (type?.contains(value) ?? false) {
        return 'assets/images/type_$value.png';
      }
    }
    return 'assets/images/type_travelgroup.png';
  }

  Widget _title(SearchItem item) {
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, _keyword));
    spans.add(TextSpan(
      text: " ${item.districtname ?? ''} ${item.zonename ?? ''}",
      style: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    ));
    return Container(
      width: 300,
      child: RichText(text: TextSpan(children: spans)),
    );
  }

  Widget _subTitle(SearchItem item) {
    return Visibility(
      visible: item.price != null || item.star != null,
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(top: 5),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: item.price ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.orange,
                ),
              ),
              TextSpan(
                text: " ${item.star ?? ''}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Iterable<TextSpan> _keywordTextSpans(String? word, String keyword) {
    List<TextSpan> spans = [];
    if (word?.isEmpty ?? true) {
      return spans;
    }
    TextStyle normalStyle = const TextStyle(
      fontSize: 16,
      color: Colors.black87,
    );
    TextStyle keywordStyle = const TextStyle(
      fontSize: 16,
      color: Colors.orange,
    );
    if (!word!.contains(keyword)) {
      spans.add(TextSpan(text: word, style: normalStyle));
      return spans;
    }
    List<String> split = word.split(keyword);
    for (var value in split) {
      if (value.isNotEmpty) {
        spans.add(TextSpan(text: keyword, style: keywordStyle));
        spans.add(TextSpan(text: value, style: normalStyle));
      }
    }
    return spans;
  }
}
