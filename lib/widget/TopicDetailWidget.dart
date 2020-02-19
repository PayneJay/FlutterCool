import 'package:flutter/material.dart';
import 'package:flutter_cool/models/topicDetail.dart';
import 'package:flutter_cool/widget/ArticleItemWidget.dart';

class TopicDetailWidget extends StatelessWidget {
  final TopicDetail _topicDetail;

  TopicDetailWidget(this._topicDetail);

  @override
  Widget build(BuildContext context) {
    //因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
    //Material Design 默认的样式风格,我们使用Material作为本路由的根。
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(_topicDetail == null ? 'Flutter' : _topicDetail.name),
              centerTitle: true,
              background: Image.asset(
                "./images/img_default.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ), //List
          SliverFixedExtentList(
            itemExtent: 120.0,
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建列表项
              return ArticleItemWidget(context, _topicDetail.articles[index]);
            },
                childCount:
                    _topicDetail == null ? 0 : _topicDetail.articles.length),
          ),
        ],
      ),
    );
  }

  void _subscribe() {}
}
