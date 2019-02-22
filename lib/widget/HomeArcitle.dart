import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'DetailPage.dart';
import 'package:myapp/http/Http.dart';
import 'dart:convert';
import 'package:myapp/models/ArticleList.dart';
import 'EmptyPage.dart';

class HomeArticle extends StatefulWidget {
  final HomeArticleState _homeArticleState = new HomeArticleState();

  @override
  createState() => _homeArticleState;
}

class HomeArticleState extends State<HomeArticle> {
  ArticleList _articleList;

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
    _getArticles();
    super.initState();
  }

  Widget _buildSuggestions() {
    if (_articleList == null) {
      return new EmptyPage();
    }
    return new ListView.builder(
        itemCount: _articleList.articles.length,
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider(color: Colors.grey);
          return _buildRow(i);
        });
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
                    child: new Text(_articleList.articles[i].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  new Text(
                      _articleList.articles[i].feed_title +
                          "  " +
                          _articleList.articles[i].rectime,
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
                  Center(child: CircularProgressIndicator()),
                  Center(
                      child: _articleList.articles[i].img.isNotEmpty
                          ? FadeInImage.memoryNetwork(
                              image: _articleList.articles[i].img,
                              placeholder: kTransparentImage /* 透明图片 */,
                            )
                          : Image(
                              image:
                                  AssetImage('images/img_banner_default.png'),
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

  void _getArticles() {
    dio
        .get(
            'https://api.tuicool.com/api/articles/hot.json?cid=0&lang=1&size=15')
        .then((response) {
      setState(() {
        print(response.toString());
        Map articleMap = json.decode(response.toString());
        _articleList = new ArticleList.fromJson(articleMap);
      });
    });
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '推荐', icon: Icons.directions_car),
  const Choice(title: '热门', icon: Icons.directions_boat),
  const Choice(title: '技术', icon: Icons.directions_bus),
  const Choice(title: '创投', icon: Icons.directions_railway),
  const Choice(title: '设计', icon: Icons.directions_subway),
  const Choice(title: '科技', icon: Icons.directions_bike),
  const Choice(title: '数码', icon: Icons.directions_walk),
  const Choice(title: '营销', icon: Icons.directions_run),
];
