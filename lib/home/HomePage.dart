import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
              ))
        ],
      ),
    );
  }
}
