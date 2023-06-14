import 'package:flutter/material.dart';

enum SearchType { home, normal, homeLight }

class SearchView extends StatefulWidget {
  final bool enabled;
  final bool hideLeft;
  final SearchType searchType;
  final String hint;
  final String? defaultText;

  final void Function()? leftButtonClick;
  final void Function()? rightButtonClick;
  final void Function()? speakButtonClick;
  final void Function()? inputButtonClick;
  final ValueChanged<String>? onChanged;

  const SearchView({
    super.key,
    this.enabled = true,
    this.hideLeft = true,
    this.searchType = SearchType.normal,
    this.hint = "",
    this.defaultText,
    this.leftButtonClick,
    this.rightButtonClick,
    this.speakButtonClick,
    this.inputButtonClick,
    this.onChanged,
  });

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (widget.searchType) {
      case SearchType.home:
      case SearchType.homeLight:
        content = _createHomeSearch(context);
        break;
      case SearchType.normal:
        content = _createNormalSearch(context);
        break;
    }
    return content;
  }

  Widget _createHomeSearch(BuildContext context) {
    return Row(
      children: [
        _wrapTop(
            Container(
              padding: const EdgeInsets.fromLTRB(6, 5, 5, 5),
              child: Row(
                children: [
                  Text(
                    "上海",
                    style: TextStyle(fontSize: 14, color: _getHomeFontColor()),
                  ),
                  Icon(
                    Icons.expand_more,
                    size: 22,
                    color: _getHomeFontColor(),
                  )
                ],
              ),
            ),
            callback: widget.leftButtonClick),
        Expanded(
          child: _createInputBox(),
          flex: 1,
        ),
        _wrapTop(
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Icon(
                Icons.comment,
                color: _getHomeFontColor(),
                size: 26,
              ),
            ),
            callback: widget.rightButtonClick),
      ],
    );
  }

  Widget _createNormalSearch(BuildContext context) {
    return Row(
      children: [
        _wrapTop(
            Container(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
              child: widget.hideLeft
                  ? null
                  : const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey,
                      size: 26,
                    ),
            ),
            callback: widget.leftButtonClick),
        Expanded(
          child: _createInputBox(),
          flex: 1,
        ),
        _wrapTop(
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: const Text(
                '搜索',
                style: TextStyle(color: Colors.blue, fontSize: 17),
              ),
            ),
            callback: widget.rightButtonClick)
      ],
    );
  }

  _createInputBox() {
    Color inputBoxColor;
    if (widget.searchType == SearchType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = const Color(0xffEDEDED);
    }
    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(
            widget.searchType == SearchType.normal ? 5 : 15),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchType == SearchType.normal
                ? const Color(0xffA9A9A9)
                : Colors.blue,
          ),
          Expanded(
            flex: 1,
            child: widget.searchType == SearchType.normal
                ? TextField(
                    controller: _controller,
                    onChanged: _onChanged,
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 14),
                      border: InputBorder.none,
                      hintText: widget.hint ?? '',
                      hintStyle: const TextStyle(fontSize: 15),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                : _wrapTop(
                    Text(
                      widget.defaultText ?? '',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    callback: widget.inputButtonClick,
                  ),
          ),
          !showClear
              ? _wrapTop(
                  Icon(
                    Icons.mic,
                    size: 22,
                    color: widget.searchType == SearchType.normal
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  callback: widget.speakButtonClick,
                )
              : _wrapTop(
                  const Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  ), callback: () {
                  setState(() {
                    _controller.clear();
                  });
                  _onChanged('');
                }),
        ],
      ),
    );
  }

  _wrapTop(Widget child, {void Function()? callback}) {
    return GestureDetector(
      onTap: () {
        if (callback != null) {
          callback();
        }
      },
      child: child,
    );
  }

  void _onChanged(String text) {
    setState(() {
      showClear = text.isNotEmpty;
    });
    widget.onChanged?.call(text);
  }

  _getHomeFontColor() {
    return widget.searchType == SearchType.homeLight
        ? Colors.black54
        : Colors.white;
  }
}
