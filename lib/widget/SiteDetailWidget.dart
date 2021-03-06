import 'package:flutter/material.dart';
import 'package:myapp/models/siteDetail.dart';
import 'package:myapp/widget/ArticleItemWidget.dart';

class SiteDetailWidget extends StatelessWidget {
  final SiteDetail _siteDetail;

  SiteDetailWidget(this._siteDetail);

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
              title: Text(_siteDetail == null ? '' : _siteDetail.site.name),
              centerTitle: true,
              background: Image.asset(
                "./images/img_default.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ), //List
          new SliverFixedExtentList(
            itemExtent: 120.0,
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建列表项
              return new ArticleItemWidget(
                  context, _siteDetail.articles[index]);
            },
                childCount:
                    _siteDetail == null ? 0 : _siteDetail.articles.length),
          ),
        ],
      ),
    );
  }
}
