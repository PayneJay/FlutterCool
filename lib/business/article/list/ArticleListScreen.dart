import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/http/Http.dart';
import 'dart:convert';
import 'package:myapp/models/articleList.dart';
import 'package:myapp/models/articles.dart';
import 'package:myapp/widget/EmptyWidget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:myapp/http/InterfaceService.dart';
import 'package:myapp/widget/ArticleItemWidget.dart';

class ArticleListScreen extends StatefulWidget {
  final ArticleListScreenState _homeArticleState = new ArticleListScreenState();

  @override
  createState() => _homeArticleState;
}

class ArticleListScreenState extends State<ArticleListScreen> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  List<Articles> _articleList = new List();

  int _currentPage;
  String _lastId = "";
  String _currentCid = "";
  bool _hasNext;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: choices.length,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueAccent,
          bottom: new PreferredSize(
              child: new TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.white54,
                unselectedLabelStyle: new TextStyle(fontSize: 12.0),
                labelColor: Colors.white,
                labelStyle: new TextStyle(fontSize: 16.0),
                indicatorColor: Colors.white,
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: choices.map((Choice choice) {
                  return new Tab(
                    text: choice.title,
                    icon: new Icon(choice.icon),
                  );
                }).toList(),
              ),
              preferredSize: Size.fromHeight(18)),
        ),
        body: new TabBarView(
          children: choices.map((Choice choice) {
            return new Padding(
              padding: const EdgeInsets.all(0.0),
              child: _buildSuggestions(),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  Widget _buildSuggestions() {
    if (_articleList == null) {
      return new EmptyWidget();
    }

    return new Center(
      child: new EasyRefresh(
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
        child: new ListView.builder(
            itemCount: _articleList.length,
            itemBuilder: (context, i) {
              return _buildRow(i);
            }),
        onRefresh: _onRefresh,
        loadMore: _loadMore,
        autoLoad: true,
        firstRefresh: true,
      ),
    );
  }

  //  创建列表条目
  Widget _buildRow(int i) {
    return new ArticleItemWidget(context, _articleList[i]);
  }

  Future _getArticles() async {
    await dio.get(articleListUrl, queryParameters: {
      "cid": _currentCid,
      "lang": 1,
      "size": 30,
      "pn": _currentPage,
      "last_id": _lastId
    }).then((response) {
      setState(() {
        ArticleList articleList =
            new ArticleList.fromJson(json.decode(response.toString()));
        _hasNext = articleList.has_next;
        _currentPage = articleList.pn;
        _articleList.addAll(articleList.articles);
        _lastId = _articleList.elementAt(_articleList.length - 1).id;
      });
    });
  }

  Future<void> _onRefresh() {
    print('---------_onRefresh--------');
    _currentPage = 0;
    _lastId = "";
    _articleList.clear();
    return _getArticles();
  }

  Future<void> _loadMore() {
    if (_hasNext) {
      print('---------_loadMore--------');
      return _getArticles();
    }
    return null;
  }
}

class Choice {
  const Choice({this.title, this.icon, this.cid});

  final String title;
  final IconData icon;
  final String cid;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '热门', icon: Icons.directions_boat, cid: '0'),
  const Choice(title: '推荐', icon: Icons.directions_car, cid: '0'),
  const Choice(title: '科技', icon: Icons.directions_bike, cid: '101000000'),
  const Choice(title: '创投', icon: Icons.directions_railway, cid: '101040000'),
  const Choice(title: '数码', icon: Icons.directions_walk, cid: '101050000'),
  const Choice(title: '技术', icon: Icons.directions_bus, cid: '20'),
  const Choice(title: '设计', icon: Icons.directions_subway, cid: '108000000'),
  const Choice(title: '营销', icon: Icons.directions_run, cid: '114000000'),
];
