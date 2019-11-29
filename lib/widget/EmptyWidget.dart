import 'package:flutter/material.dart';

class EmptyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EmptyWidgetState();
  }
}

class EmptyWidgetState extends State<EmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return _createEmptyPage(context);
  }
}

Widget _createEmptyPage(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height -
        kToolbarHeight -
        kBottomNavigationBarHeight,
    padding: EdgeInsets.all(32.0),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('images/icon_empty.png'),
          Container(
            margin: const EdgeInsets.only(top: 18.0),
            child: Text('暂时还没有内容哦',
                style: TextStyle(
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
