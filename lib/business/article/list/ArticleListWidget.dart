import 'package:flutter/material.dart';
import 'package:myapp/http/Http.dart';
import 'dart:convert';
import 'package:myapp/models/articleList.dart';
import 'package:myapp/models/articles.dart';
import 'package:myapp/widget/EmptyWidget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:myapp/http/InterfaceService.dart';
import 'package:myapp/widget/ArticleItemWidget.dart';
import 'package:myapp/business/article/list/ArticleTabBarWidget.dart';

class ArticleListWidget extends StatefulWidget {
  final Choice _choice;

  ArticleListWidget(this._choice);

  @override
  State<StatefulWidget> createState() => ArticleListWidgetState(_choice);
}

class ArticleListWidgetState extends State<ArticleListWidget> {
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
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
      child: EasyRefresh(
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
            itemCount: _articleList.length,
            itemBuilder: (context, i) {
              return _buildRow(i);
            }),
        onRefresh: _onRefresh,
        loadMore: _loadMore,
        autoLoad: true,
        firstRefresh: true,
        emptyWidget: EmptyWidget(),
      ),
    );
  }

  //  创建列表条目
  Widget _buildRow(int i) {
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
