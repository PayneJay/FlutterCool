import 'package:flutter/material.dart';

class EmptyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new EmptyWidgetState();
  }
}

class EmptyWidgetState extends State<EmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return _createEmptyPage();
  }
}

Widget _createEmptyPage() {
  return new Container(
    padding: new EdgeInsets.all(32.0),
    child: new Center(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('images/icon_empty.png'),
          new Container(
            margin: const EdgeInsets.only(top: 18.0),
            child: new Text('暂时还没有内容哦',
                style: new TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.lightBlueAccent,
                )),
          )
        ],
      ),
    ),
  );
}
