import 'package:flutter/material.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";

class RatingPage extends StatefulWidget {
  @override
  PullToRefresh createState() => new PullToRefresh();
}

class PullToRefresh extends State<RatingPage> {
//  RefreshMode  refreshing = RefreshMode.idle;
//  LoadMode loading = LoadMode.idle;
  RefreshController _refreshController;
  List<Widget> data = [];

  void _getDatas() {
    for (int i = 0; i < 14; i++) {
      data.add(new Card(
        margin:
        new EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
        child: new Center(
          child: new Text('Data $i'),
        ),
      ));
    }
  }

  void enterRefresh() {
    _refreshController.requestRefresh(true);
  }

  void _onOffsetCallback(bool isUp, double offset) {
    // if you want change some widgets state ,you should rewrite the callback
  }

  @override
  void initState() {
    _getDatas();
    _refreshController = new RefreshController();
    super.initState();
  }

  Widget _footerCreate(BuildContext context, int mode) {
    return new ClassicIndicator(
      mode: mode,
      refreshingText: "",
      idleIcon: new Container(),
      idleText: "Load more...",
    );
  }

  Widget _headerCreate(BuildContext context, int mode) {
    return new ClassicIndicator(mode: mode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PullToRefresh'),
      ),
      body: new Container(
          child: new SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              headerBuilder: _headerCreate,
              footerBuilder: _footerCreate,
              controller: _refreshController,
              onOffsetChange: _onOffsetCallback,
              child: new ListView.builder(
                reverse: true,
                itemExtent: 100.0,
                itemCount: data.length,
                itemBuilder: (context, index) => new Item(),
              ))),
    );
  }
}

class Item extends StatefulWidget {
  @override
  _ItemState createState() => new _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return new Card(
      margin:
      new EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: new Center(
        child: new Text('Data'),
      ),
    );
  }

  @override
  void dispose() {
    print("销毁");
    super.dispose();
  }
}
