import 'package:flutter/material.dart';
import 'package:cool/widget/EmptyWidget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:cool/http/Http.dart';
import 'package:cool/http/InterfaceService.dart';
import 'dart:convert';
import 'package:cool/models/magDirs.dart';
import 'package:cool/models/magGroup.dart';
import 'package:cool/business/discover/mag/PeriodListScreen.dart';
import 'package:cool/widget/PeriodItemWidget.dart';

class MagazineWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MagazineWidgetState();
}

class MagazineWidgetState extends State<MagazineWidget> {
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  List<MagGroup> _magGroup = List();

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      key: _easyRefreshKey,
      behavior: ScrollOverBehavior(),
      refreshHeader: PhoenixHeader(
        key: _headerKey,
      ),
      child: ListView.builder(
          itemCount: _magGroup.length,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return _magGroup.length == 0
                ? EmptyWidget()
                : _buildExpandTiles(_magGroup[i]);
          }),
      onRefresh: _getMagDir,
      autoLoad: true,
      firstRefresh: true,
      emptyWidget: EmptyWidget(),
    );
  }

  Future _getMagDir() async {
    await dio.get(magazineUrl).then((response) {
      setState(() {
        MagDirs magDirs = MagDirs.fromJson(jsonDecode(response.toString()));
        _magGroup = magDirs.items;
      });
    });
  }

  Widget _buildExpandTiles(MagGroup group) {
    if (group == null) return ListTile(title: Text('must not be null'));
    return Column(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            color: Color(0x11000000),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(group.name,
                    style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
                GestureDetector(
                  child: Text('更多',
                      style: TextStyle(fontSize: 16, color: Colors.black45)),
                  onTap: () {
                    _goPeriodList(group);
                  },
                )
              ],
            )),
        Container(
          child: ListView.builder(
              itemCount: group.items.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return PeriodItemWidget(group.items[i], context);
              }),
        )
      ],
    );
  }

  void _goPeriodList(MagGroup group) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PeriodListScreen(group);
    }));
  }
}
