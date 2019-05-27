import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:myapp/http/Http.dart';

class RefreshWithHttp extends StatefulWidget {
  @override
  RefreshWithHttpState createState() => new RefreshWithHttpState();
}

class RefreshWithHttpState extends State<RefreshWithHttp>
    with TickerProviderStateMixin {
  int indexPage = 1;
  List<String> data = [];

  void _fetch() {
    dio
        .get(
            'http://image.baidu.com/channel/listjson?pn=$indexPage&rn=30&tag1=%E6%98%8E%E6%98%9F&tag2=%E5%85%A8%E9%83%A8&ie=utf8')
        .then((r) {
      Map map = json.decode(r.data);
      print(map);
      return map["data"];
    }).then((array) {
      for (var item in array) {
        data.add(item["image_url"]);
      }
      setState(() {});
      indexPage++;
    }).catchError(() {
    });
  }

  Widget buildImage(context, index) {
    return new Item(
      url: data[index],
    );
  }

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Text("content");
  }
}

class Item extends StatefulWidget {
  final String url;

  Item({this.url});

  @override
  _ItemState createState() => new _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    if (widget.url == null) return new Container();
    return new RepaintBoundary(
      child: new Image.network(
        widget.url,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  void dispose() {
    print("销毁");
    super.dispose();
  }
}
