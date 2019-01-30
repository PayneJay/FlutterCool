import 'package:flutter/material.dart';

class RatingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rating",
      home: RatingAppState(),
    );
  }
}

class RatingAppState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NewsListpageState();
  }
}

class NewsListpageState extends State<RatingAppState> {
  var curPage = 1;
  ScrollController _controller = new ScrollController();
  var listData = List<String>.generate(30, (i) => "CL $i");

  Future<Null> _pullToRefresh() async {
//    curPage = 1;
    //下拉刷新做处理
    setState(() {
      ////改变数据，这里随意发挥
      listData = List<String>.generate(30, (i) => "CL $i");
    });
    return null;
  }

  NewsListpageState() {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;

      if (maxScroll == pixels && listData.length < 100) {
//        上拉刷新做处理
        print('load more ...');
//        curPage++;
        setState(() {
          //改变数据，这里随意发挥
          listData = List<String>.generate(100, (i) => "CL $i");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget listView = new ListView.builder(
      itemCount: listData.length,
      itemBuilder: (context, i) {
        //这里填充自己想要的列表UI
        return new Container(
          height: 45.0,
          color: Colors.blue,
          child: new Text(
            "$i",
            style: new TextStyle(fontSize: 15.0),
          ),
        );
      },
      controller: _controller,
    );
    return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
  }
}
