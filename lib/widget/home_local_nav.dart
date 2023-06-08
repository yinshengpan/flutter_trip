import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class HomeLocalNavView extends StatelessWidget {
  final List<CommonModel>? localNavList;

  const HomeLocalNavView({super.key, this.localNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (localNavList == null) {
      return null;
    }
    List<Widget> widgets = localNavList!.map((model) {
      return _item(context, model);
    }).toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) {
          return WebView(
            url: model.url ?? "",
            title: model.title,
            statusBarColor: model.statusBarColor,
            hideAppBar: model.hideAppBar,
          );
        }));
      },
      child: Column(
        children: [
          Image.network(
            model.icon ?? "",
            width: 32,
            height: 32,
          ),
          Text(
            model.title ?? "",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
