import 'package:flutter/material.dart';
import 'package:myapp/home/BottomNavigationWidget.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();  // 删除此行

    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(primaryColor: Colors.blueAccent),
      home: new BottomNavigationWidget(),
    );
  }
}
