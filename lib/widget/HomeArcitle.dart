import 'package:flutter/material.dart';
import 'DetailPage.dart';
import 'EmptyPage.dart';

class HomeArticle extends StatefulWidget {
  final HomeArticleState _homeArcitleState = new HomeArticleState();

  @override
  createState() => _homeArcitleState;
}

class HomeArticleState extends State<HomeArticle> {
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

  Widget _buildSuggestions() {
    return new ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd) return new Divider();
      return _buildRow();
    });
  }

  Widget _buildRow() {
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
                    child: new Text(
                        'TabBar可用于在TabBarView中显示的页面之间导航。虽然TabBar是一个可以出现在任何地方的普通widget，但它通常包含在应用程序的AppBar中。',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  new Text('腾讯科技 02-19 15:51',
                      style: new TextStyle(
                        color: Colors.grey[500],
                      ))
                ],
              ),
            ),
            new Container(
              width: 120,
              height: 80,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new NetworkImage(
                          'https://images.unsplash.com/photo-1471115853179-bb1d604434e0?dpr=1&auto=format&fit=crop&w=767&h=583&q=80&cs=tinysrgb&crop='),
                      fit: BoxFit.cover)),
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
