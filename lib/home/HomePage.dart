import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'dart:math' as math;

const APPBAR_MAX_SCROLL = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List _imageList = [
  "https://picsum.photos/250?image=9",
  "http://www.devio.org/img/avatar.png",
  "https://picsum.photos/250?image=9",
  "http://www.devio.org/img/avatar.png"
];

class _HomePageState extends State<HomePage> {
  double _appBarAlpha = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: ListView(
                  children: [
                    Container(
                        height: 220,
                        child: Swiper(
                          itemCount: _imageList.length,
                          autoplay: true,
                          pagination: SwiperPagination(),
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              _imageList[index],
                              fit: BoxFit.fill,
                            );
                          },
                        )),
                    Container(
                      height: 800,
                      child: ListTile(
                        title: Text("哈哈"),
                      ),
                    )
                  ],
                ),
              )),
          Opacity(
            opacity: _appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("首页"),
                ),
              ),
            ),
          ),
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
}
