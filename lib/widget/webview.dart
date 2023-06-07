
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebView extends StatefulWidget {
  final String url;
  final String? title;
  final String? statusBarColor;
  final bool? hideAppBar;
  final bool? backForbid;

  WebView(
      {required this.url,
      this.title,
      this.statusBarColor = 'ffffff',
      this.hideAppBar = false,
      this.backForbid = false});

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
      scrollbarFadingEnabled: false,
      useWideViewPort: true,
      displayZoomControls: false,
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
    String statusColor = widget.statusBarColor ?? 'ffffff';
    Color backColor = statusColor == 'ffffff' ? Colors.black : Colors.white;
    return Scaffold(
      body: Column(
        children: [
          _appBar(Color(int.parse('0xff$statusColor')), backColor),
          _createWebView()
        ],
      ),
    );
  }

  Widget _appBar(Color bgColor, Color backColor) {
    if (widget.hideAppBar ?? false) {
      return Container();
    }
    return Container(
      decoration: BoxDecoration(color: bgColor),
      height: 100,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            Positioned(
                top: 30,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    _controller?.canGoBack().then((canGoBack) {
                      if (canGoBack) {
                        _controller?.goBack();
                      } else {
                        Navigator.pop(context);
                      }
                    }).onError((error, stackTrace) {
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.arrow_back,
                      color: backColor,
                      size: 24,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                right: 0,
                top: 30,
                bottom: 0,
                child: Center(
                  child: Text(
                    widget.title ?? _pageTitle ?? "",
                    style: TextStyle(color: backColor, fontSize: 26),
                  ),
                ))
          ],
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
          print("shouldOverrideUrlLoading url ${navigationAction.request.url}");
          return null;
        },
        onWebViewCreated: (controller) {
          _controller = controller;
          _handleJsBridge();
        },
      ),
    );
  }

  void _handleJsBridge() {}
}
