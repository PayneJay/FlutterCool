import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:cool/http/Http.dart';
import 'package:cool/widget/ArticleItemWidget.dart';
import 'package:cool/http/InterfaceService.dart';
import 'package:cool/models/articleSearch.dart';
import 'package:cool/models/articles.dart';
import 'package:cool/widget/EmptyWidget.dart';
import 'package:cool/event/EventBus.dart';
import 'package:cool/event/SearchEvent.dart';

class ArticleResultWidget extends StatefulWidget {
  final String _inputText;

  ArticleResultWidget(this._inputText);

  @override
  State<StatefulWidget> createState() => ArticleResultWidgetState(_inputText);
}

class ArticleResultWidgetState extends State<ArticleResultWidget> {
  var _articles = List<Articles>();

  var _currentPage;

  var _hasNext;

  StreamSubscription<SearchEvent> subscription;

  String _keyWord;

  ArticleResultWidgetState(this._keyWord);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        header: ClassicalHeader(
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          infoColor: Colors.black54,
        ),
        footer: ClassicalFooter(
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          infoColor: Colors.black54,
        ),
        child: ListView.builder(
            itemBuilder: (context, index) {
              return ArticleItemWidget(context, _articles[index]);
            },
            itemCount: _articles.length,
            itemExtent: 120),
        onRefresh: _onRefresh,
        onLoad: _loadMore,
        firstRefresh: true,
        emptyWidget: EmptyWidget());
  }

  Future _searchArticles() async {
    await dio.get(articleSearchUrl,
        queryParameters: {"pn": _currentPage, "kw": _keyWord}).then((response) {
      setState(() {
        ArticleSearch result =
            ArticleSearch.fromJson(json.decode(response.toString()));
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
