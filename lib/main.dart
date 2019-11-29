import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:myapp/business/home/BottomNavigationWidget.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(primaryColor: Colors.blueAccent),
        home: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  num _lastClickTime;

  @override
  void initState() {
    super.initState();
    _register();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationWidget();
  }

//  Future<bool> _doubleExit() {
//    int nowTime = DateTime.now().microsecondsSinceEpoch;
//    if (_lastClickTime != 0 && nowTime - _lastClickTime > 1500) {
//      return Future.value(true);
//    } else {
//      _lastClickTime = DateTime.now().microsecondsSinceEpoch;
//      Future.delayed(const Duration(milliseconds: 1500), () {
//        _lastClickTime = 0;
//      });
//      return Future.value(false);
//    }
//  }

  _register() {
//  注册
    fluwx.register(appId: "wx974682567cca6ff8");
  }
}
