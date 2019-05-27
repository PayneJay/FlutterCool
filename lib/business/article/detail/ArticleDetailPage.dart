import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myapp/share/ShareApp.dart';
import 'package:myapp/http/Http.dart';
import 'package:myapp/models/articleDetail.dart';
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:overlay_support/overlay_support.dart';

class ArticleDetailPage extends StatefulWidget {
  final String _id;

  ArticleDetailPage(this._id);

  @override
  State<StatefulWidget> createState() {
    return ArticleDetailPageState(_id);
  }
}

class ArticleDetailPageState extends State<ArticleDetailPage> {
  final String _articleId;

  ArticleDetailPageState(this._articleId);

  @override
  Widget build(BuildContext context) {
    _context = context;
    _screenWidth = MediaQuery.of(context).size.width;
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
          new IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: _more,
          )
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
        _url = article.url;
        _htmlContent = parse(article.content).outerHtml;
      });
    });
  }
}

BuildContext _context;
double _screenWidth = 0;
String _title;
String _time;
String _feedTitle;
String _url;
String _htmlContent;

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
void _more() {
  toast(_context, 'more');
}

//url跳转
_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget _buildDetail() {
  return Scrollbar(
      child: SingleChildScrollView(
    child: new Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            color: Colors.blueAccent,
            padding: const EdgeInsets.all(15),
            width: _screenWidth,
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
              data: _htmlContent,
              defaultTextStyle: TextStyle(fontSize: 16),
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
  ));
}
