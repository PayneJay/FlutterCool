import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:myapp/http/Http.dart';
import 'package:myapp/widget/ArticleItemWidget.dart';
import 'package:myapp/http/InterfaceService.dart';
import 'package:myapp/models/articleSearch.dart';
import 'package:myapp/models/articles.dart';
import 'package:myapp/widget/EmptyWidget.dart';
import 'package:myapp/event/EventBus.dart';
import 'package:myapp/event/SearchEvent.dart';

class ArticleResultWidget extends StatefulWidget {
  final String _inputText;

  ArticleResultWidget(this._inputText);

  @override
  State<StatefulWidget> createState() => ArticleResultWidgetState(_inputText);
}

class ArticleResultWidgetState extends State<ArticleResultWidget> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  var _articles = new List<Articles>();

  var _currentPage;

  var _hasNext;

  StreamSubscription<SearchEvent> subscription;

  String _keyWord;

  ArticleResultWidgetState(this._keyWord);

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
        child: ListView.builder(
            itemBuilder: (context, index) {
              return ArticleItemWidget(context, _articles[index]);
            },
            itemCount: _articles.length,
            itemExtent: 120),
        onRefresh: _onRefresh,
        loadMore: _loadMore,
        autoLoad: true,
        firstRefresh: true,
        emptyWidget: new EmptyWidget());
  }

  Future _searchArticles() async {
    await dio.get(articleSearchUrl,
        queryParameters: {"pn": _currentPage, "kw": _keyWord}).then((response) {
      setState(() {
        ArticleSearch result =
            new ArticleSearch.fromJson(json.decode(response.toString()));
        _hasNext = result.has_next;
        _currentPage = result.pn;
        _articles.addAll(result.articles);
      });
    });
  }

  Future<void> _onRefresh() async {
    _currentPage = 0;
    _articles.clear();
    return _searchArticles();
  }

  Future<void> _loadMore() async {
    if (_hasNext) {
      return _searchArticles();
    }
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
    super.dispose();
    subscription.cancel();
  }
}
