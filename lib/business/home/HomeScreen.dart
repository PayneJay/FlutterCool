import 'package:flutter/material.dart';
import 'package:myapp/business/article/list/ArticleListScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  ArticleListScreen _article = new ArticleListScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _article,
    );
  }
}
