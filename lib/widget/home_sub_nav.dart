import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/http/model/home_model.dart';
import 'package:flutter_trip/widget/webview.dart';
import 'dart:math' as math;

class HomeSubNavView extends StatelessWidget {
  final List<CommonModel>? subNavList;

  const HomeSubNavView({super.key, this.subNavList});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: subNavList != null,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: _items(context),
        ),
      ),
    );
  }

  _items(BuildContext context) {
    if (subNavList == null) {
      return null;
    }
    List<Widget> widgets = subNavList!.map((model) {
      return _item(context, model);
    }).toList();
    List<Widget> subList1 = widgets.sublist(0, math.min(widgets.length, 5));
    List<Widget> subList2 = [];
    if (widgets.length > 5) {
      subList2 = widgets.sublist(5, math.min(widgets.length, 10));
      while (subList2.length < 5) {
        subList2.add(Expanded(
          flex: 1,
          child: Container(),
        ));
      }
    }
    return Column(
      children: [
        Visibility(
          visible: subList1.isNotEmpty,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: subList1,
          ),
        ),
        Visibility(
          visible: subList2.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: subList2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
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
              width: 24,
              height: 24,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                model.title ?? "",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
