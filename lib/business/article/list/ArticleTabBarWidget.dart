import 'package:flutter/material.dart';
import 'package:myapp/business/article/list/ArticleListWidget.dart';

class ArticleTabBarWidget extends StatefulWidget {
  @override
  createState() => ArticleTabBarWidgetState();
}

class ArticleTabBarWidgetState extends State<ArticleTabBarWidget>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        bottom: PreferredSize(
            child: TabBar(
                controller: _controller,
                isScrollable: true,
                unselectedLabelColor: Colors.white54,
                unselectedLabelStyle: TextStyle(fontSize: 14.0),
                labelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 16.0),
                indicatorColor: Colors.white,
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: choices.map((Choice choice) {
                  return Tab(
                    text: choice.title,
                  );
                }).toList()),
            preferredSize: Size.fromHeight(-8)),
      ),
      body: TabBarView(
        controller: _controller,
        children: choices.map((Choice choice) {
          return Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: ArticleListWidget(choice),
          );
        }).toList(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: choices.length, vsync: this);
  }

  @override
  void dispose() {
    //先调用controller.dispose释放了动画资源，再调用super
    _controller?.dispose();
    super.dispose();
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
