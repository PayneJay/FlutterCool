import 'package:flutter/material.dart';
import 'package:myapp/event/EventBus.dart';
import 'package:myapp/widget/EmptyWidget.dart';
import 'package:myapp/business/search/ArticleResultWidget.dart';
import 'package:myapp/business/search/TopicResultWidget.dart';
import 'package:myapp/business/search/SiteResultWidget.dart';
import 'package:myapp/business/search/BookResultWidget.dart';
import 'package:myapp/event/SearchChangeEvent.dart';

class SearchResultWidget extends StatefulWidget {
  final String _inputText;

  SearchResultWidget(this._inputText);

  @override
  SearchResultWidgetState createState() => new SearchResultWidgetState();
}

class SearchResultWidgetState extends State<SearchResultWidget>
    with SingleTickerProviderStateMixin {
  final choices = ['文章', '主题', '站点', '图书'];
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                controller: _tabController),
            preferredSize: Size.fromHeight(-8)),
      ),
      body: new TabBarView(
          children: choices.map((String tab) {
            return new Padding(
              padding: const EdgeInsets.all(0.0),
              child: buildResultList(tab),
            );
          }).toList(),
          controller: _tabController),
    );
  }

  Widget buildResultList(String tab) {
    switch (choices.indexOf(tab)) {
      case 0:
        return ArticleResultWidget(widget._inputText);
      case 1:
        return TopicResultWidget(widget._inputText);
      case 2:
        return SiteResultWidget(widget._inputText);
      case 3:
        return BookResultWidget(widget._inputText);
    }
    return EmptyWidget();
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: choices.length, vsync: this)
      ..addListener(() {
        String choice = choices[_tabController.index];
        eventBus.fire(new SearchChangeEvent(choice));
      });
  }
}
