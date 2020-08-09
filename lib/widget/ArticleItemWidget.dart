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
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        decoration: new BoxDecoration(
                            border: new Border.all(
                          //新手建议给每一个组件写一个border
                          color: const Color(0xff6d9eeb),
                        )),
                        child: Text(
                          _articles.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Container(
                        decoration: new BoxDecoration(
                            border: new Border.all(
                          //新手建议给每一个组件写一个border
                          color: const Color(0xff6d9eeb),
                        )),
                        child: Text(
                          _articles.feed_title + "  " + _articles.rectime,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: const EdgeInsets.only(right: 10)),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      //剪裁为圆角矩形
                      borderRadius: BorderRadius.circular(5.0),
                      child: _buildImageView(),
                    ),
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
