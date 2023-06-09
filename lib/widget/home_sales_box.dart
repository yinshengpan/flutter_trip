import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home_model.dart';

import 'webview.dart';

class HomeSalesBoxView extends StatelessWidget {
  final SalesBoxModel? salesBoxModel;

  const HomeSalesBoxView({this.salesBoxModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: _createSalesBox(context),
    );
  }

  _createSalesBox(BuildContext context) {
    if (salesBoxModel == null) {
      return null;
    }
    return Column(
      children: [
        _createSalesBoxTitle(context, salesBoxModel),
        _createSalesBoxItem(
            context, salesBoxModel?.bigCard1, salesBoxModel?.bigCard2, 200),
        _createSalesBoxItem(
            context, salesBoxModel?.smallCard1, salesBoxModel?.smallCard2, 60),
        _createSalesBoxItem(
            context, salesBoxModel?.smallCard3, salesBoxModel?.smallCard4, 60),
      ],
    );
  }

  Widget _createSalesBoxItem(BuildContext context, CommonModel? lModel,
      CommonModel? rModel, double height) {
    return Row(
      children: [
        _createItem(context, lModel, height),
        _createItem(context, rModel, height),
      ],
    );
  }

  Widget _createItem(BuildContext context, CommonModel? model, double height) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
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
        child: Container(
          child: Image.network(
            model?.icon ?? "",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  _createSalesBoxTitle(BuildContext context, SalesBoxModel? salesBoxModel) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Image.network(
              salesBoxModel?.icon ?? "",
              fit: BoxFit.fill,
              height: 20,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 1, 5, 1),
            margin: EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [
                  Color(0xfff4e63),
                  Color(0xffff6cc9),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return WebView(
                    url: salesBoxModel?.moreUrl ?? "",
                  );
                }));
              },
              child: const Text(
                "获取更多福利 >",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          )
          // Image.network(salesBoxModel?.moreUrl ?? ""),
        ],
      ),
    );
  }
}
