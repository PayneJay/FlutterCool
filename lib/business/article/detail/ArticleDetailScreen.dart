import 'package:flutter/material.dart';
import 'package:cool/business/comment/CommentScreen.dart';
import 'package:cool/share/SharePanel.dart';
import 'package:cool/widget/LoadingDialog.dart';
import 'package:cool/widget/PictureWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cool/http/Http.dart';
import 'package:cool/models/articleDetail.dart';
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:cool/http/InterfaceService.dart';

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: _share,
          ),
          IconButton(
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

  void _getArticleDetail() async {
    await dio.get(getArticleDetailUrl(_articleId),
        queryParameters: {"is_pad": 1, "need_image_meta": 1}).then((response) {
      setState(() {
        ArticleDetail articleDetail =
            ArticleDetail.fromJson(json.decode(response.toString()));
        var article = articleDetail.article;
        _title = article.title;
        _time = article.time;
        _feedTitle = article.feed_title;
        _url = article.url;
        _htmlContent = parse(article.content).outerHtml;
      });
    });
  }
}

BuildContext _context;
String _title = '';
String _time = '';
String _feedTitle = '';
String _url;
String _imageUrl =
    'https://yijiangaitu.com/static/20190709/20190709142225.61e38b0a10740205cbc09474c0ee5806.png';
String _htmlContent = '';
OverlayEntry overlayEntry;

//分享
_share() {
  showModalBottomSheet(
      context: _context,
      builder: (BuildContext context) {
        return SharePanel(_url, _title, _feedTitle, _imageUrl);
      });
}

//评论
void _comment() {
  Navigator.of(_context).push(MaterialPageRoute(builder: (context) {
    return CommentScreen();
  }));
}

//更多菜单
Widget _more() {
  return PopupMenuButton<MenuItem>(
    //这是点击弹出菜单的操作，点击对应菜单后，改变屏幕中间文本状态，将点击的菜单值赋予屏幕中间文本
    onSelected: (MenuItem value) {
      print('*****' + value.title);
    },
    offset: Offset(0, kToolbarHeight),
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

_onImageTap(String source) {
  Navigator.of(_context).push(MaterialPageRoute(builder: (context) {
    return PictureWidget(source);
  }));
}

Widget _getProgressDialog() {
  return LoadingDialog(
    //调用对话框
    text: '正在获取详情...',
  );
}

Widget _buildDetail() {
  if (_title.isEmpty) {
    return _getProgressDialog();
  }
  return SingleChildScrollView(
    child: Container(
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
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  maxLines: 2,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Text(
                    _feedTitle + '  ' + _time,
                    style: TextStyle(fontSize: 13, color: Colors.white70),
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
              onImageTap: (source) {
                _onImageTap(source);
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
