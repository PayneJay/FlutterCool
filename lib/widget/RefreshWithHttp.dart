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
  RefreshController _controller;
  int indexPage = 1;
  List<String> data = [];

  void _fetch() {
    dio.get('http://image.baidu.com/channel/listjson?pn=$indexPage&rn=30&tag1=%E6%98%8E%E6%98%9F&tag2=%E5%85%A8%E9%83%A8&ie=utf8')
        .then((r) {
      Map map = json.decode(r.data);
      print(map);
      return map["data"];
    }).then((array) {
      for (var item in array) {
        data.add(item["image_url"]);
      }
      setState(() {});
      _controller.sendBack(false, RefreshStatus.idle);
      indexPage++;
    }).catchError(() {
      _controller.sendBack(false, RefreshStatus.failed);
    });
  }

  void _onRefresh(bool up) {
    if (up)
      new Future.delayed(const Duration(milliseconds: 300)).then((val) {
        _fetch();
      });
    else {
      print("sd");
      new Future.delayed(const Duration(milliseconds: 300)).then((val) {
        _controller.sendBack(true, RefreshStatus.completed);
//                refresher.sendStatus(RefreshStatus.completed);
      });
    }
  }

  Widget buildImage(context, index) {
    return new Item(
      url: data[index],
    );
  }

  void _onOffsetCallback(bool isUp, double offset) {
    // if you want change some widgets state ,you should rewrite the callback
    if (isUp) {
    } else {}
  }

  @override
  void initState() {
    super.initState();
    _controller = new RefreshController();
    _fetch();
  }

  Widget _headerCreate(BuildContext context, int mode) {
    return new ClassicIndicator(mode: mode);
  }

  Widget _footerCreate(BuildContext context, int mode) {
    return new ClassicIndicator(
      mode: mode,
      refreshingText: 'loading...',
      idleIcon: const Icon(Icons.arrow_upward),
      idleText: 'Loadmore...',
    );
  }

  @override
  Widget build(BuildContext context) {
    return new SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: _controller,
      onRefresh: _onRefresh,
      headerBuilder: _headerCreate,
      footerBuilder: _footerCreate,
      footerConfig: new RefreshConfig(),
      onOffsetChange: _onOffsetCallback,
      child: new GridView.builder(
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: data.length,
        itemBuilder: buildImage,
      ),
    );
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
