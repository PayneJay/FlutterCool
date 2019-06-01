import 'package:flutter/material.dart';
import 'package:myapp/widget/EmptyWidget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:myapp/http/Http.dart';
import 'package:myapp/http/InterfaceService.dart';
import 'dart:convert';
import 'package:myapp/models/magDirs.dart';
import 'package:myapp/models/magGroup.dart';
import 'package:myapp/business/discover/PeriodListScreen.dart';
import 'package:myapp/widget/PeriodItemWidget.dart';

class MagazineWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MagazineWidgetState();
}

class MagazineWidgetState extends State<MagazineWidget> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  List<MagGroup> _magGroup = List();

  @override
  Widget build(BuildContext context) {
    return new EasyRefresh(
      key: _easyRefreshKey,
      behavior: ScrollOverBehavior(),
      refreshHeader: PhoenixHeader(
        key: _headerKey,
      ),
      child: new ListView.builder(
          itemCount: _magGroup.length,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return _magGroup.length == 0
                ? EmptyWidget()
                : _buildChildTiles(_magGroup[i]);
          }),
      onRefresh: _getMagDir,
      autoLoad: true,
      firstRefresh: true,
      emptyWidget: new EmptyWidget(),
    );
  }

  Future _getMagDir() async {
    await dio.get(magazineUrl).then((response) {
      setState(() {
        MagDirs magDirs = new MagDirs.fromJson(jsonDecode(response.toString()));
        _magGroup = magDirs.items;
      });
    });
  }

  Widget _buildChildTiles(MagGroup group) {
    if (group == null) return new ListTile(title: new Text('must not be null'));
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              color: Color(0x11000000),
              child: Text(group.name,
                  style: TextStyle(fontSize: 16, color: Colors.blueAccent))),
          onTap: () {
            _goPeriodList(group);
          },
        ),
        Container(
          child: ListView.builder(
              itemCount: group.items.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return PeriodItemWidget(group.items[i]);
              }),
          margin: const EdgeInsets.only(top: 10),
        )
      ],
    );
  }

  void _goPeriodList(MagGroup group) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new PeriodListScreen(group);
    }));
  }
}
