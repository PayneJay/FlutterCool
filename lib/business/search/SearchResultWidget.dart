import 'package:flutter/material.dart';
import 'package:myapp/widget/EmptyWidget.dart';

class SearchResultWidget extends StatefulWidget {
  @override
  SearchResultWidgetState createState() => new SearchResultWidgetState();
}

class SearchResultWidgetState extends State<SearchResultWidget> {
  @override
  Widget build(BuildContext context) {
    final choices = ['文章', '主题', '站点'];
    return new DefaultTabController(
      length: choices.length,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueAccent,
          bottom: new PreferredSize(
              child: new TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.white54,
                labelColor: Colors.white,
                labelStyle: new TextStyle(fontSize: 16.0),
                indicatorColor: Colors.white,
                indicatorWeight: 2,
                tabs: choices.map((String tab) {
                  return new Tab(text: tab);
                }).toList(),
              ),
              preferredSize: Size.fromHeight(-8)),
        ),
        body: new TabBarView(
          children: choices.map((String tab) {
            return new Padding(
              padding: const EdgeInsets.all(0.0),
              child: _buildList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}

Widget _buildList() {
  return new EmptyWidget();
}
