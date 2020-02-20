import 'package:flutter/material.dart';
import 'package:cool/models/magDetailChild.dart';
import 'package:cool/business/article/detail/ArticleDetailScreen.dart';

class MagDetailChildItemWidget extends StatelessWidget {
  final MagDetailChild _magChild;

  final BuildContext _context;

  const MagDetailChildItemWidget(this._magChild, this._context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                child: Text(
                  _magChild == null ? '' : _magChild.title,
                  style: TextStyle(fontSize: 16),
                )),
            Divider(
              color: Colors.black12,
              height: 1,
            )
          ],
        ),
        onTap: () {
          _onPeriodItemClick();
        });
  }

  void _onPeriodItemClick() {
    Navigator.of(_context).push(MaterialPageRoute(builder: (context) {
      return ArticleDetailScreen(_magChild.url);
    }));
  }
}
