import 'package:flutter/material.dart';
import 'package:myapp/widget/EmptyWidget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:myapp/http/Http.dart';
import 'package:myapp/http/InterfaceService.dart';
import 'dart:convert';
import 'package:myapp/models/bookList.dart';
import 'package:myapp/models/bookGroup.dart';
import 'package:myapp/models/bookChild.dart';
import 'package:myapp/widget/BookItemWidget.dart';

class BookTagScreen extends StatefulWidget {
  final BookGroup _bookGroup;

  const BookTagScreen(this._bookGroup);

  @override
  State<StatefulWidget> createState() => BookTagScreenState(_bookGroup);
}

class BookTagScreenState extends State<BookTagScreen> {
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  final BookGroup _bookGroup;
  var _tagId;
  var _currentPage = 0;
  bool _hasNext;
  List<BookChild> _bookList = List();

  BookTagScreenState(this._bookGroup);

  @override
  Widget build(BuildContext context) {
    _tagId = _bookGroup.tagId;
    return Scaffold(
        appBar:
            AppBar(title: Text(_bookGroup == null ? '' : _bookGroup.tagName)),
        body: EasyRefresh(
          key: _easyRefreshKey,
          behavior: ScrollOverBehavior(),
          refreshHeader: PhoenixHeader(key: _headerKey),
          refreshFooter: ClassicsFooter(
            key: _footerKey,
            bgColor: Colors.transparent,
            textColor: Colors.black87,
            moreInfoColor: Colors.black54,
            showMore: true,
          ),
          child: _bookList.length == 0
              ? EmptyWidget()
              : _buildChildTiles(_bookList),
          onRefresh: _onRefresh,
          loadMore: _loadMore,
          autoLoad: true,
          firstRefresh: true,
          emptyWidget: EmptyWidget(),
        ));
  }

  Future<void> _getBookDir() async {
    await dio.get(bookTagUrl,
        queryParameters: {'tag': _tagId, 'pn': _currentPage}).then((response) {
      setState(() {
        BookList bookList = BookList.fromJson(jsonDecode(response.toString()));
        if (_currentPage == 0) {
          _bookList.clear();
        }
        _bookList.addAll(bookList.items);
        _hasNext = bookList.has_next;
      });
    });
  }

  Widget _buildChildTiles(List<BookChild> list) {
    if (list == null) return ListTile(title: Text('must not be null'));
    return Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //每行三列
              childAspectRatio: 0.6,
            ),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: BookItemWidget(list[index], context));
            }));
  }

  Future<void> _onRefresh() {
    _currentPage = 0;
    return _getBookDir();
  }

  Future<void> _loadMore() {
    if (_hasNext) {
      _currentPage++;
      return _getBookDir();
    }
    return null;
  }
}
