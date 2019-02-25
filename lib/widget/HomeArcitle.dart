import 'dart:async';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'DetailPage.dart';
import 'package:myapp/http/Http.dart';
import 'dart:convert';
import 'package:myapp/models/ArticleList.dart';
import 'EmptyPage.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomeArticle extends StatefulWidget {
  final HomeArticleState _homeArticleState = new HomeArticleState();

  @override
  createState() => _homeArticleState;
}

class HomeArticleState extends State<HomeArticle> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  List<Article> _articleList = new List();

  int _currentIndex;

//  String _lastId = "";
  String _currentCid = "";
  bool _hasNext;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: choices.length,
      child: new Scaffold(
        appBar: new AppBar(
          title: const Text('Tabbed AppBar'),
          backgroundColor: Colors.white,
          bottom: new TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.black54,
            labelColor: Colors.blueAccent,
            tabs: choices.map((Choice choice) {
              return new Tab(
                text: choice.title,
                icon: new Icon(choice.icon),
              );
            }).toList(),
          ),
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
    _onRefresh();
    super.initState();
  }

  Widget _buildSuggestions() {
    if (_articleList == null) {
      return new EmptyPage();
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
              if (i.isOdd) return new Divider(color: Colors.grey);
              return _buildRow(i);
            }),
        onRefresh: _onRefresh,
        loadMore: _loadMore,
        autoLoad: true,
        firstRefresh: true,
      ),
    );
  }

  Widget _buildRow(int i) {
    return new GestureDetector(
      child: new Container(
        padding: const EdgeInsets.all(10.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                    child: new Text(_articleList[i].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  new Text(
                      _articleList[i].feed_title +
                          "  " +
                          _articleList[i].rectime,
                      style: new TextStyle(
                        color: Colors.grey[500],
                      ))
                ],
              ),
            ),
            new Container(
              width: 120,
              height: 80,
              child: Stack(
                children: <Widget>[
                  //图片加载loading
//                  Center(child: CircularProgressIndicator()),
                  Center(
                      child: _articleList[i].img.isNotEmpty
                          ? FadeInImage.memoryNetwork(
                              image: _articleList[i].img,
                              placeholder: kTransparentImage /* 透明图片 */,
                            )
                          : Image(
                              image: AssetImage('images/IMG_3910.JPG'),
                            )),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: _viewDetail,
    );
  }

  void _viewDetail() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new DetailPage();
    }));
  }

  Future _getArticles() async {
    await dio.get("https://api.tuicool.com/api/articles/hot.json?",
        queryParameters: {
          "cid": _currentCid,
          "lang": 1,
          "size": 30,
          "pn": _currentIndex,
          "last_id": ""
        }).then((response) {
      setState(() {
        ArticleList articleList =
            new ArticleList.fromJson(json.decode(response.toString()));
        _hasNext = articleList.has_next;
        _articleList.addAll(articleList.articles);
//        _lastId = _articleList.elementAt(_articleList.length).id;
      });
    });
  }

  Future<void> _onRefresh() {
    print('---------_onRefresh--------');
    _currentIndex = 0;
    _articleList.clear();
    return _getArticles();
  }

  Future<void> _loadMore() {
    if (_hasNext) {
      _currentIndex++;
      print('---------_loadMore--------');
      return _getArticles();
    }

    return null;
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '热门', icon: Icons.directions_boat),
  const Choice(title: '推荐', icon: Icons.directions_car),
  const Choice(title: '科技', icon: Icons.directions_bike),
  const Choice(title: '创投', icon: Icons.directions_railway),
  const Choice(title: '数码', icon: Icons.directions_walk),
  const Choice(title: '技术', icon: Icons.directions_bus),
  const Choice(title: '设计', icon: Icons.directions_subway),
  const Choice(title: '营销', icon: Icons.directions_run),
];
