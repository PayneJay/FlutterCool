import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:cool/business/home/BottomNavigationWidget.dart';

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
  @override
  void initState() {
    super.initState();
    _register();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() {
      return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('确定退出?'),
              content: Text('您要退出应用程序吗？'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('取消'),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('确定'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(child: BottomNavigationWidget(), onWillPop: _onWillPop);
  }

  _register() {
    ///  注册
    fluwx.registerWxApi(appId: "wx974682567cca6ff8");
  }
}
