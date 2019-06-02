import 'package:flutter/material.dart';
import 'package:myapp/models/bookChild.dart';
import 'package:myapp/widget/WebViewWidget.dart';

class BookItemWidget extends StatelessWidget {
  final BookChild _bookChild;

  final BuildContext _context;

  const BookItemWidget(this._bookChild, this._context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Column(
          children: <Widget>[
            Image(image: NetworkImage(_bookChild.thumb)),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Text(_bookChild.title,
                    style: TextStyle(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis))
          ],
        ),
        onTap: () {
          _goBookSale();
        });
  }

  void _goBookSale() {
    Navigator.of(_context).push(new MaterialPageRoute(builder: (context) {
      return new WebViewWidget(_bookChild.link, _bookChild.title);
    }));
  }
}
