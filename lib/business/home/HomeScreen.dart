import 'package:flutter/material.dart';
import 'package:myapp/business/article/list/ArticleTabBarWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArticleTabBarWidget(),
    );
  }
}
