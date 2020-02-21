import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cool/models/articles.dart';
import 'package:cool/business/article/detail/ArticleDetailScreen.dart';

class ArticleItemWidget extends StatelessWidget {
  final Articles _articles;
  final BuildContext _context;

  const ArticleItemWidget(this._context, this._articles);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Card(
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ), //设置圆角
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 10),
                        child: Text(
                          _articles.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Text(
                        _articles.feed_title + "  " + _articles.rectime,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 120,
                  height: 80,
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        //剪裁为圆角矩形
                        borderRadius: BorderRadius.circular(5.0),
                        child: _buildImageView(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        _viewDetail();
      },
    );
  }

  Widget _buildImageView() {
    return _articles.img.isNotEmpty
        ? Material(
            child: FadeInImage.memoryNetwork(
              image: _articles.img,
              placeholder: kTransparentImage /* 透明图片 */,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)))
        : Image(image: AssetImage('images/img_default.jpg'), fit: BoxFit.cover);
  }

  void _viewDetail() {
    Navigator.of(_context).push(MaterialPageRoute(builder: (context) {
      return ArticleDetailScreen(_articles.id);
    }));
  }
}
