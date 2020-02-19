import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:cool/event/EventBus.dart';
import 'package:cool/event/SearchEvent.dart';
import 'package:cool/http/Http.dart';
import 'package:cool/http/InterfaceService.dart';
import 'package:cool/models/bookSearch.dart';
import 'package:cool/models/bookChild.dart';
import 'package:cool/widget/EmptyWidget.dart';
import 'package:cool/widget/WebViewWidget.dart';
import 'package:transparent_image/transparent_image.dart';

class BookResultWidget extends StatefulWidget {
  final String _inputText;

  BookResultWidget(this._inputText);

  @override
  State<StatefulWidget> createState() => BookResultWidgetState(_inputText);
}

class BookResultWidgetState extends State<BookResultWidget> {
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  var _books = List<BookChild>();

  var _currentPage;

  bool _hasNext;

  String _keyWord;

  StreamSubscription<SearchEvent> subscription;

  BookResultWidgetState(this._keyWord);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        key: _easyRefreshKey,
        behavior: ScrollOverBehavior(),
        refreshHeader: ClassicsHeader(
          key: _headerKey,
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          moreInfoColor: Colors.black54,
          showMore: true,
        ),
        refreshFooter: ClassicsFooter(
          key: _footerKey,
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          moreInfoColor: Colors.black54,
          showMore: true,
        ),
        child: _buildListView(),
        onRefresh: _onRefresh,
        loadMore: _loadMore,
        autoLoad: true,
        firstRefresh: true,
        emptyWidget: EmptyWidget());
  }

  Widget _buildListView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
              child: Container(
                  height: 80,
                  padding: const EdgeInsets.only(
                      left: 10, top: 5, right: 10, bottom: 5),
                  child: Row(
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Stack(
                            children: <Widget>[
                              Center(
                                  child: _books[index].thumb.isNotEmpty
                                      ? Material(
                                          child: FadeInImage.memoryNetwork(
                                            image: _books[index].thumb,
                                            fit: BoxFit.fill,
                                            placeholder:
                                                kTransparentImage /* 透明图片 */,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)))
                                      : Image(
                                          image: AssetImage(
                                              'images/img_default.jpg'),
                                          fit: BoxFit.fill))
                            ],
                          )),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_books[index].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                          Text(_books[index].author,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey[500]))
                        ],
                      ))
                    ],
                  )),
              onTap: () {
                _onItemClick(_books[index]);
              });
        },
        separatorBuilder: (context, index) {
          return Divider(color: Colors.black12);
        },
        itemCount: _books.length);
  }

  Future _searchBooks() async {
    await dio.get(bookSearchUrl,
        queryParameters: {"kw": _keyWord, "pn": _currentPage}).then((response) {
      setState(() {
        BookSearch result =
            BookSearch.fromJson(json.decode(response.toString()));
        _books.addAll(result.items);
        _hasNext = result.has_next;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    subscription = eventBus.on<SearchEvent>().listen((event) {
      setState(() {
        _keyWord = event.keyWord;
        _onRefresh();
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    _currentPage = 0;
    _books.clear();
    return _searchBooks();
  }

  Future<void> _loadMore() async {
    if (_hasNext) {
      _currentPage++;
      return _searchBooks();
    }
    return null;
  }

  void _onItemClick(BookChild book) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return WebViewWidget(book.link, book.title);
    }));
  }
}
