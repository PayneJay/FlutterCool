import 'package:flutter/material.dart';
import 'package:cool/http/Http.dart';
import 'dart:convert';
import 'package:cool/models/articleList.dart';
import 'package:cool/models/articles.dart';
import 'package:cool/widget/EmptyWidget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:cool/http/InterfaceService.dart';
import 'package:cool/widget/ArticleItemWidget.dart';
import 'package:cool/business/article/list/ArticleTabBarWidget.dart';

class ArticleListWidget extends StatefulWidget {
  final Choice _choice;

  ArticleListWidget(this._choice);

  @override
  State<StatefulWidget> createState() => ArticleListWidgetState(_choice);
}

class ArticleListWidgetState extends State<ArticleListWidget> {
  List<Articles> _articleList = List();

  final Choice _choice;
  int _currentPage;
  String _lastId = "";
  bool _hasNext;

  ArticleListWidgetState(this._choice);

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }

  Widget _buildSuggestions() {
    if (_choice.title == '推荐') {
      return EmptyWidget();
    }

    return Center(
      child: EasyRefresh.custom(
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
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return _buildRow(context, index);
            }, childCount: _articleList.length),
          ),
        ],
        onRefresh: _onRefresh,
        onLoad: _loadMore,
        firstRefresh: true,
        emptyWidget: _articleList.length == 0 ? EmptyWidget() : null,
      ),
    );
  }

  //  创建列表条目
  Widget _buildRow(BuildContext context, int i) {
    return ArticleItemWidget(context, _articleList[i]);
  }

  Future _getArticles() async {
    await dio.get(articleListUrl, queryParameters: {
      "cid": _choice.cid,
      "lang": 1,
      "size": 30,
      "pn": _currentPage,
      "last_id": _lastId
    }).then((response) {
      setState(() {
        ArticleList articleList =
            ArticleList.fromJson(json.decode(response.toString()));
        _hasNext = articleList.has_next;
        _currentPage = articleList.pn;
        _articleList.addAll(articleList.articles);
        _lastId = _articleList.elementAt(_articleList.length - 1).id;
      });
    });
  }

  Future _onRefresh() async {
    _currentPage = 0;
    _lastId = "";
    _articleList.clear();
    return _getArticles();
  }

  Future _loadMore() async {
    if (_hasNext) {
      return _getArticles();
    }
    return null;
  }
}
