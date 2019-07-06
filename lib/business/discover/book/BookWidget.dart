import 'package:flutter/material.dart';
import 'package:myapp/widget/EmptyWidget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:myapp/http/Http.dart';
import 'package:myapp/http/InterfaceService.dart';
import 'dart:convert';
import 'package:myapp/models/bookDirs.dart';
import 'package:myapp/models/bookGroup.dart';
import 'package:myapp/business/discover/book/BookTagScreen.dart';
import 'package:myapp/widget/BookItemWidget.dart';

class BookWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new BookWidgetState();
}

class BookWidgetState extends State<BookWidget> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  List<BookGroup> _bookGroup = List();

  @override
  Widget build(BuildContext context) {
    return new EasyRefresh(
      key: _easyRefreshKey,
      behavior: ScrollOverBehavior(),
      refreshHeader: PhoenixHeader(
        key: _headerKey,
      ),
      child: new ListView.builder(
          shrinkWrap: true,
          itemCount: _bookGroup.length,
          itemBuilder: (context, i) {
            return _bookGroup.length == 0
                ? EmptyWidget()
                : _buildExpandTiles(_bookGroup[i]);
          }),
      onRefresh: _getBookDir,
      autoLoad: true,
      firstRefresh: true,
      emptyWidget: new EmptyWidget(),
    );
  }

  Future<void> _getBookDir() async {
    await dio.get(bookUrl).then((response) {
      setState(() {
        BookDirs bookDirs =
            new BookDirs.fromJson(jsonDecode(response.toString()));
        _bookGroup = bookDirs.items;
      });
    });
  }

  Widget _buildExpandTiles(BookGroup group) {
    if (group == null) return new ListTile(title: new Text('must not be null'));
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(group.tagName,
                  style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
              GestureDetector(
                child: Text('更多',
                    style: TextStyle(fontSize: 16, color: Colors.black45)),
                onTap: () {
                  _goBookList(group);
                },
              )
            ],
          ),
          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
          color: Color(0x11000000),
          width: MediaQuery.of(context).size.width,
        ),
        GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //每行三列
              childAspectRatio: 0.6,
            ),
            itemCount: group.books.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: BookItemWidget(group.books[index], context));
            })
      ],
    );
  }

  void _goBookList(BookGroup group) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new BookTagScreen(group);
    }));
  }
}
