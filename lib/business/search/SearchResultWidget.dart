import 'package:flutter/material.dart';
import 'package:cool/event/EventBus.dart';
import 'package:cool/widget/EmptyWidget.dart';
import 'package:cool/business/search/ArticleResultWidget.dart';
import 'package:cool/business/search/TopicResultWidget.dart';
import 'package:cool/business/search/SiteResultWidget.dart';
import 'package:cool/business/search/BookResultWidget.dart';
import 'package:cool/event/SearchChangeEvent.dart';

class SearchResultWidget extends StatefulWidget {
  final String _inputText;

  SearchResultWidget(this._inputText);

  @override
  SearchResultWidgetState createState() => SearchResultWidgetState();
}

class SearchResultWidgetState extends State<SearchResultWidget>
    with SingleTickerProviderStateMixin {
  final choices = ['文章', '主题', '站点', '图书'];
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        bottom: PreferredSize(
            child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.white54,
                labelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 16.0),
                indicatorColor: Colors.white,
                indicatorWeight: 2,
                tabs: choices.map((String tab) {
                  return Tab(text: tab);
                }).toList(),
                controller: _tabController),
            preferredSize: Size.fromHeight(-8)),
      ),
      body: TabBarView(
          children: choices.map((String tab) {
            return Padding(
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
    _tabController = TabController(length: choices.length, vsync: this)
      ..addListener(() {
        String choice = choices[_tabController.index];
        eventBus.fire(SearchChangeEvent(choice));
      });
  }
}
