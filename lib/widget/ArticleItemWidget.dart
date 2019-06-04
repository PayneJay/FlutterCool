import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:myapp/models/articles.dart';
import 'package:myapp/business/article/detail/ArticleDetailScreen.dart';

class ArticleItemWidget extends StatelessWidget {
  final Articles _articles;
  final BuildContext _context;

  const ArticleItemWidget(this._context, this._articles);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Container(
        margin: const EdgeInsets.fromLTRB(10, 3, 10, 5),
        child: Card(
          elevation: 3,
          child: Container(
              padding: const EdgeInsets.all(15),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                            child: new Text(_articles.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))),
                        new Container(
                            child: new Text(
                                _articles.feed_title + "  " + _articles.rectime,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(color: Colors.grey[500])))
                      ],
                    ),
                  ),
                  new Container(
                      width: 120,
                      height: 80,
                      child: Stack(
                        children: <Widget>[
                          Center(
                              child: _articles.img.isNotEmpty
                                  ? new Material(
                                      child: FadeInImage.memoryNetwork(
                                        image: _articles.img,
                                        placeholder:
                                            kTransparentImage /* 透明图片 */,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          new Radius.circular(5)))
                                  : Image(
                                      image:
                                          AssetImage('images/img_default.jpg'),
                                      fit: BoxFit.cover))
                        ],
                      ))
                ],
              )),
        ),
      ),
      onTap: () {
        _viewDetail();
      },
    );
  }

  void _viewDetail() {
    Navigator.of(_context).push(new MaterialPageRoute(builder: (context) {
      return new ArticleDetailScreen(_articles.id);
    }));
  }
}
