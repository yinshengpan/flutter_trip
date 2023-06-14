import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WebView extends StatefulWidget {
  final String url;
  final String? title;
  final String? statusBarColor;
  final bool? hideAppBar;

  WebView(
      {required this.url,
      this.title,
      this.statusBarColor = 'ffffff',
      this.hideAppBar = false});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  String? _pageTitle;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? _controller;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      supportZoom: true,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
      useWideViewPort: true,
      displayZoomControls: false,
      verticalScrollbarThumbColor: Colors.transparent,
      horizontalScrollbarThumbColor: Colors.transparent,
      mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
      builtInZoomControls: true,
      allowFileAccess: true,
      domStorageEnabled: true,
      blockNetworkImage: false,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (!widget.url.startsWith('http')) {
      Fluttertoast.showToast(msg: '当前链接不支持', toastLength: Toast.LENGTH_SHORT);
      Navigator.pop(context);
      return Container();
    }
    String statusColorStr = widget.statusBarColor ?? 'ffffff';
    Color backColor = statusColorStr == 'ffffff' ? Colors.black : Colors.white;
    Color statusColor = Color(int.parse('0xff$statusColorStr'));
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Platform.isIOS
          ? _createIOSContent(statusColor, backColor)
          : _createContent(statusColor, backColor),
    );
  }

  Widget _createIOSContent(Color statusColor, Color backColor) {
    double startDragDx = 0;
    double dragDx = 0;
    int MIN_DRAG_BACK_DX = 100;
    int START_DRAG_LIMIT = 120;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragStart: (details) {
        startDragDx = details.globalPosition.dx;
      },
      onHorizontalDragUpdate: (details) {
        dragDx += details.delta.dx;
      },
      onHorizontalDragEnd: (details) {
        print("startDragDx $startDragDx dragDx $dragDx");
        if (startDragDx < START_DRAG_LIMIT && dragDx > MIN_DRAG_BACK_DX) {
          _handleBack();
        }
      },
      child: _createContent(statusColor, backColor),
    );
  }

  Widget _createContent(Color statusColor, Color backColor) {
    return Scaffold(
      body: Container(
        color: statusColor,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _appBar(statusColor, backColor),
              _createWebView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar(Color statusColor, Color backColor) {
    if (widget.hideAppBar ?? false) {
      return Container();
    }
    return AppBar(
      backgroundColor: statusColor,
      centerTitle: true,
      title: Text(
        widget.title ?? _pageTitle ?? "",
        style: TextStyle(
          fontSize: 22,
          color: backColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          _handleBack();
        },
        child: Icon(
          Icons.arrow_back,
          color: backColor,
          size: 28,
        ),
      ),
    );
  }

  Widget _createWebView() {
    return Expanded(
      child: InAppWebView(
        key: webViewKey,
        initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
        initialOptions: options,
        onLoadStart: (controller, url) {
          print("onLoadStart url $url");
        },
        onLoadStop: (controller, url) async {
          String? title = await _controller?.getTitle();
          print("onLoadStop url $url title $title");
          if (widget.title == null) {
            setState(() {
              _pageTitle = title;
            });
          }
        },
        onLoadError: (controller, url, code, message) {
          print("onLoadError url $url code $code message $message");
        },
        onLoadHttpError: (controller, url, code, message) {
          print("onLoadHttpError url $url code $code message $message");
        },
        onConsoleMessage: (controller, message) {
          print("onConsoleMessage message $message");
        },
        onProgressChanged: (controller, progress) {
          print("onProgressChanged progress $progress");
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          String url = navigationAction.request.url.toString();
          print("shouldOverrideUrlLoading url $url");
          return NavigationActionPolicy.ALLOW;
        },
        onWebViewCreated: (controller) {
          _controller = controller;
          _handleJsBridge();
        },
      ),
    );
  }

  void _handleJsBridge() {}

  void _handleBack() {
    _controller?.canGoBack().then((canBack) {
      print("_handleBack canBack $canBack");
      if (canBack) {
        _controller?.goBack();
      } else {
        Navigator.pop(context);
      }
    });
  }

  Future<bool> _onWillPop() async {
    if (await _controller?.canGoBack() ?? false) {
      await _controller?.goBack();
      return Future(() => false);
    }
    return Future(() => true);
  }
}
