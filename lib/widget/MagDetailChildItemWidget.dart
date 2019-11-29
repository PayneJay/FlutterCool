import 'package:flutter/material.dart';
import 'package:myapp/models/magDetailChild.dart';
import 'package:myapp/business/article/detail/ArticleDetailScreen.dart';

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
                padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                child: Text(
                  _magChild == null ? '' : _magChild.title,
                  style: TextStyle(fontSize: 16),
                )),
            Divider(
              color: Colors.black12,
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
