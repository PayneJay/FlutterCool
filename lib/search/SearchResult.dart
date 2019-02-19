import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  @override
  SearchResultState createState() => new SearchResultState();
}

class SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    final choices = ['文章', '主题', '站点'];
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
            tabs: choices.map((String tab) {
              return new Tab(text: tab);
            }).toList(),
          ),
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
  return new Center();
}
