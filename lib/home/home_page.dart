import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_trip/http/dao/crazy_dao.dart';
import 'package:flutter_trip/http/model/home_model.dart';
import 'package:flutter_trip/search/search_page.dart';
import 'dart:math' as math;

import 'package:flutter_trip/widget/home_grid_nav.dart';
import 'package:flutter_trip/widget/home_local_nav.dart';
import 'package:flutter_trip/widget/home_sales_box.dart';
import 'package:flutter_trip/widget/home_sub_nav.dart';
import 'package:flutter_trip/widget/search_view.dart';

const APPBAR_MAX_SCROLL = 100;
const SEARCH_HINT = "网红打卡地，景区，酒店";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _appBarAlpha = 0;
  HomeModel? _homeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2fafa),
      body: Stack(
        children: [
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener(
              onNotification: (scroll) {
                if (scroll is ScrollUpdateNotification && scroll.depth == 0) {
                  _onScroll(scroll.metrics.pixels);
                  return true;
                }
                return false;
              },
              child: EasyRefresh(
                onRefresh: () {
                  _refresh();
                },
                child: ListView(
                  children: [
                    _createBanner(_homeModel?.bannerList),
                    _createLocalNav(_homeModel?.localNavList),
                    _createGridNav(_homeModel?.gridNav),
                    _createSubNav(_homeModel?.subNavList),
                    _createSalesBox(_homeModel?.salesBox),
                  ],
                ),
              ),
            ),
          ),
          _createAppBar(),
        ],
      ),
    );
  }

  void _onScroll(double pixels) {
    setState(() {
      double alpha = pixels / APPBAR_MAX_SCROLL;
      alpha = math.max(0, alpha);
      alpha = math.min(1, alpha);
      setState(() {
        _appBarAlpha = alpha;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  _refresh() async {
    try {
      final homeModel = await CrazyDao.fetchHome();
      setState(() {
        _homeModel = homeModel;
      });
    } catch (e) {
      print(e);
    }
  }

  _createBanner(List<CommonModel>? bannerList) {
    return Visibility(
      visible: bannerList?.isNotEmpty ?? false,
      child: Container(
        height: 220,
        child: Swiper(
          itemCount: bannerList?.length ?? 0,
          autoplay: true,
          pagination: SwiperPagination(),
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              bannerList![index].icon!,
              fit: BoxFit.fill,
            );
          },
        ),
      ),
    );
  }

  _createLocalNav(List<CommonModel>? localNavList) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, top: 4, right: 7, bottom: 4),
      child: HomeLocalNavView(
        localNavList: localNavList,
      ),
    );
  }

  _createGridNav(GridNav? gridNav) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7, top: 0, bottom: 4),
      child: HomeGridNavView(gridNav: gridNav),
    );
  }

  _createSubNav(List<CommonModel>? subNavList) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7, top: 0, bottom: 4),
      child: HomeSubNavView(subNavList: subNavList),
    );
  }

  _createSalesBox(SalesBoxModel? model) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7, top: 0, bottom: 4),
      child: HomeSalesBoxView(salesBoxModel: model),
    );
  }

  _createAppBar() {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x66000000), Colors.transparent],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter),
          ),
          child: Container(
            padding: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color:
                  Color.fromARGB((_appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SafeArea(
              child: SearchView(
                searchType:
                    _appBarAlpha > 0.2 ? SearchType.homeLight : SearchType.home,
                inputButtonClick: () {
                  Navigator.push(
                    context,
                    CupertinoModalPopupRoute(builder: (BuildContext context) {
                      return const SearchPage(
                        hint: SEARCH_HINT,
                      );
                    }),
                  );
                },
                speakButtonClick: () {},
                defaultText: SEARCH_HINT,
                leftButtonClick: () {},
              ),
            ),
          ),
        ),
        Container(
          height: _appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 0.5),
            ],
          ),
        )
      ],
    );
  }
}
