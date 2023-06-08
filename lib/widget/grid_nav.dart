import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home_model.dart';

import 'webview.dart';

class GridNavView extends StatelessWidget {
  final GridNav? gridNav;

  GridNavView({this.gridNav});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _gridNavList(context),
    );
  }

  List<Widget> _gridNavList(BuildContext context) {
    List<Widget> gridNavList = [];
    gridNavList.add(_gridNavItem(context, gridNav?.hotel, TextAlign.start));
    gridNavList.add(_gridNavItem(context, gridNav?.flight, TextAlign.center));
    gridNavList.add(_gridNavItem(context, gridNav?.travel, TextAlign.end));
    return gridNavList;
  }

  Widget _gridNavItem(
      BuildContext context, GridNavItem? item, TextAlign align) {
    Color startColor = Color(int.parse('0xff${item?.startColor ?? 'ffffff'}'));
    Color endColor = Color(int.parse('0xff${item?.endColor ?? 'ffffff'}'));
    BorderRadius borderRadius;
    Radius radius = Radius.circular(8);
    switch (align) {
      case TextAlign.start:
        borderRadius = BorderRadius.only(topLeft: radius, topRight: radius);
        break;
      case TextAlign.end:
        borderRadius =
            BorderRadius.only(bottomLeft: radius, bottomRight: radius);
        break;
      case TextAlign.center:
      default:
        borderRadius = BorderRadius.zero;
        break;
    }
    return Visibility(
      visible: item != null,
      child: Container(
        height: 88,
        margin: const EdgeInsets.only(top: 3),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(colors: [startColor, endColor]),
        ),
        child: Row(
          children: [
            Expanded(
              child: _wrapGesture(
                  context, item?.mainItem, _mainItem(context, item?.mainItem)),
              flex: 1,
            ),
            Expanded(
              child: _doubleItem(context, item?.item1, item?.item2),
              flex: 1,
            ),
            Expanded(
              child: _doubleItem(context, item?.item3, item?.item4),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainItem(BuildContext context, CommonModel? mainItem) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Image.network(
          mainItem?.icon ?? "",
          width: 88,
          height: 121,
          alignment: AlignmentDirectional.bottomCenter,
        ),
        Positioned(
          top: 11,
          child: Text(
            mainItem?.title ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  _doubleItem(BuildContext context, CommonModel? item1, CommonModel? item2) {
    return Column(
      children: [
        Expanded(
          child: _wrapGesture(context, item1, _navItem(context, item1, false)),
        ),
        Expanded(
          child: _wrapGesture(context, item2, _navItem(context, item2, true)),
        ),
      ],
    );
  }

  Widget _navItem(BuildContext context, CommonModel? item, bool isBottomItem) {
    BorderSide border = const BorderSide(
      width: 0.8,
      color: Colors.white,
    );
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: border,
            bottom: isBottomItem ? BorderSide.none : border,
          ),
        ),
        child: Center(
          child: Text(
            item?.title ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _wrapGesture(BuildContext context, CommonModel? model, Widget widget) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) {
          return WebView(
            url: model?.url ?? "",
            title: model?.title,
            statusBarColor: model?.statusBarColor,
            hideAppBar: model?.hideAppBar,
          );
        }));
      },
      child: widget,
    );
  }
}
