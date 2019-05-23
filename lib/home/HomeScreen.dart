import 'package:flutter/material.dart';
import 'package:myapp/business/article/list/ArcitleList.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  HomeArticle _article = new HomeArticle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _article,
    );
  }
}
