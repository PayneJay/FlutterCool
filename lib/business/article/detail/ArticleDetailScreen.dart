import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myapp/share/ShareApp.dart';
import 'package:myapp/http/Http.dart';
import 'package:myapp/models/articleDetail.dart';
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:overlay_support/overlay_support.dart';

class ArticleDetailScreen extends StatefulWidget {
  final String _id;

  ArticleDetailScreen(this._id);

  @override
  State<StatefulWidget> createState() {
    return ArticleDetailScreenState(_id);
  }
}

class ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final String _articleId;

  ArticleDetailScreenState(this._articleId);

  @override
  Widget build(BuildContext context) {
    _context = context;
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: _share,
          ),
          new IconButton(
            icon: Icon(Icons.comment, color: Colors.white),
            onPressed: _comment,
          ),
          _more()
        ],
      ),
      body: _buildDetail(),
    );
  }

  @override
  void initState() {
    _getArticleDetail();
    super.initState();
  }

//"https://api.tuicool.com/api/articles/$_articleId.json?is_pad=1&need_image_meta=1"
  void _getArticleDetail() async {
    await dio.get("/api/articles/$_articleId.json",
        queryParameters: {"is_pad": 1, "need_image_meta": 1}).then((response) {
      setState(() {
        ArticleDetail articleDetail =
            new ArticleDetail.fromJson(json.decode(response.toString()));
        var article = articleDetail.article;
        _title = article.title;
        _time = article.time;
        _feedTitle = article.feed_title;
//        _url = article.url;
        _htmlContent = parse(article.content).outerHtml;
      });
    });
  }
}

BuildContext _context;
String _title = '';
String _time = '';
String _feedTitle = '';
//String _url;
String _htmlContent = '';
OverlayEntry overlayEntry;

//分享
_share() {
  Navigator.of(_context).push(new MaterialPageRoute(builder: (context) {
    return new ShareApp();
  }));
}

//评论
void _comment() {
  toast(_context, 'comment');
}

//更多菜单
Widget _more() {
  return new PopupMenuButton<MenuItem>(
    //这是点击弹出菜单的操作，点击对应菜单后，改变屏幕中间文本状态，将点击的菜单值赋予屏幕中间文本
    onSelected: (MenuItem value) {
      print('*****' + value.title);
    },
    offset: new Offset(0, kToolbarHeight),
    //这是弹出菜单的建立
    itemBuilder: (context) => [
          getPopupMenuItem(menus[0]),
          getPopupMenuItem(menus[1]),
          getPopupMenuItem(menus[2]),
          getPopupMenuItem(menus[3]),
          getPopupMenuItem(menus[4]),
          getPopupMenuItem(menus[5]),
          getPopupMenuItem(menus[6]),
          getPopupMenuItem(menus[7]),
        ],
  );
}

PopupMenuItem<MenuItem> getPopupMenuItem(MenuItem item) {
  return PopupMenuItem(
    value: item,
    child: Text(item.title),
  );
}

//url跳转
_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget _getProgressDialog() {
  return new Center(child: new CircularProgressIndicator());
}

Widget _buildDetail() {
  if (_title.isEmpty) {
    return _getProgressDialog();
  }
  return SingleChildScrollView(
    child: new Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            color: Colors.blueAccent,
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(_context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Text(
                  _title,
                  style: new TextStyle(fontSize: 20, color: Colors.white),
                  maxLines: 2,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Text(
                    _feedTitle + '  ' + _time,
                    style: new TextStyle(fontSize: 13, color: Colors.white70),
                    maxLines: 1,
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Html(
              data: _htmlContent.trim(),
              defaultTextStyle: TextStyle(fontSize: 18, height: 1.4),
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              linkStyle: const TextStyle(
                color: Colors.blueAccent,
                decorationColor: Colors.blueAccent,
                decoration: TextDecoration.underline,
              ),
              onLinkTap: (url) {
                _launchURL(url);
              },
            ),
          )
        ],
      ),
    ),
  );
}

class MenuItem {
  const MenuItem({this.title, this.id});

  final String title;
  final int id;
}

const List<MenuItem> menus = const <MenuItem>[
  const MenuItem(title: '添加待读', id: 0),
  const MenuItem(title: '添加收藏', id: 1),
  const MenuItem(title: '调整字号', id: 2),
  const MenuItem(title: '背景设置', id: 3),
  const MenuItem(title: '打开翻页', id: 4),
  const MenuItem(title: '文章纠错', id: 5),
  const MenuItem(title: '查看原文', id: 6),
  const MenuItem(title: '复制链接', id: 7),
];
