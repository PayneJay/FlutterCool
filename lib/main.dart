import 'package:flutter/material.dart';
import 'package:myapp/business/home/BottomNavigationWidget.dart';

void main() => runApp(new MaterialApp(
      home: new MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();  // 删除此行
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      theme: new ThemeData(primaryColor: Colors.blueAccent),
      home: new BottomNavigationWidget(),
    );
  }
}
