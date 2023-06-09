import 'package:flutter/material.dart';
import 'package:flutter_trip/home/home_page.dart';
import 'package:flutter_trip/mine/mine_page.dart';
import 'package:flutter_trip/search/search_page.dart';
import 'package:flutter_trip/travel/travel_page.dart';
import 'package:flutter_trip/widget/keep_alive_wrapper.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handlePageChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_handlePageChanged);
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          KeepAliveWrapper(HomePage()),
          KeepAliveWrapper(SearchPage()),
          KeepAliveWrapper(TravelPage()),
          KeepAliveWrapper(MinePage()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _activeColor,
        unselectedItemColor: _defaultColor,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        items: [
          _createBottomItem(Icons.home, "首页"),
          _createBottomItem(Icons.search, "搜索"),
          _createBottomItem(Icons.camera_alt, "旅拍"),
          _createBottomItem(Icons.account_circle, "我的"),
        ],
      ),
    );
  }

  _createBottomItem(IconData? icon, String title) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _defaultColor,
      ),
      activeIcon: Icon(
        icon,
        color: _activeColor,
      ),
      label: title,
    );
  }

  void _handlePageChanged() {
    setState(() {
      _currentIndex = _controller.page?.round() ?? 0;
    });
  }
}
