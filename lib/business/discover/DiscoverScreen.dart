import 'package:flutter/material.dart';
import 'package:cool/business/discover/mag/MagazineWidget.dart';
import 'package:cool/business/discover/book/BookWidget.dart';
import 'package:cool/business/search/SearchScreen.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DiscoverScreenState();
}

class DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    final choices = ["专栏", "图书"];
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.blueAccent,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                _goSearch();
              },
            )
          ],
          title: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.white54,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 18.0),
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              tabs: choices.map((String tab) {
                return Tab(text: tab);
              }).toList()),
        ),
        body: TabBarView(
          children: <Widget>[MagazineWidget(), BookWidget()],
        ),
      ),
    );
  }

  void _goSearch() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SearchScreen();
    }));
  }
}
