import 'package:flutter/material.dart';
import 'package:myapp/business/article/list/ArcitleListPage.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  ArticleListPage _article = new ArticleListPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _article,
    );
  }
}
