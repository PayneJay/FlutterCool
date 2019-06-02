import 'package:flutter/material.dart';
import 'package:myapp/business/discover/mag/MagazineWidget.dart';
import 'package:myapp/business/discover/book/BookWidget.dart';
import 'package:myapp/business/search/SearchScreen.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DiscoverScreenState();
}

class DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    final choices = ["专栏", "图书"];
    return new DefaultTabController(
      length: choices.length,
      child: new Scaffold(
        appBar: new AppBar(
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
          title: new TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.white54,
              labelColor: Colors.white,
              labelStyle: new TextStyle(fontSize: 18.0),
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              tabs: choices.map((String tab) {
                return new Tab(text: tab);
              }).toList()),
        ),
        body: new TabBarView(
          children: <Widget>[MagazineWidget(), BookWidget()],
        ),
      ),
    );
  }

  void _goSearch() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new SearchScreen();
    }));
  }
}
