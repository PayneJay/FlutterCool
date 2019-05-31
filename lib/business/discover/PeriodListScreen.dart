import 'package:flutter/material.dart';
import 'package:myapp/models/magGroup.dart';
import 'package:myapp/widget/EmptyWidget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:myapp/http/Http.dart';
import 'package:myapp/http/InterfaceService.dart';
import 'dart:convert';
import 'package:myapp/models/periodList.dart';
import 'package:myapp/models/magChild.dart';
import 'package:myapp/widget/PeriodItemWidget.dart';

class PeriodListScreen extends StatefulWidget {
  final MagGroup _child;

  PeriodListScreen(this._child);

  @override
  State<StatefulWidget> createState() => new PeriodListScreenState(_child);
}

class PeriodListScreenState extends State<PeriodListScreen> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();

  final MagGroup _magGroup;
  var _type;
  List<MagChild> _periodList = List();

  PeriodListScreenState(this._magGroup);

  @override
  Widget build(BuildContext context) {
    _type = _magGroup.type;
    return new Scaffold(
        appBar: AppBar(title: Text(_magGroup == null ? '' : _magGroup.name)),
        body: new EasyRefresh(
          key: _easyRefreshKey,
          behavior: ScrollOverBehavior(),
          refreshHeader: PhoenixHeader(key: _headerKey),
          child: _periodList.length == 0
              ? EmptyWidget()
              : _buildChildTiles(_periodList),
          onRefresh: _onRefresh,
          autoLoad: true,
          firstRefresh: true,
          emptyWidget: new EmptyWidget(),
        ));
  }

  Future<void> _getPeriodList() async {
    await dio
        .get(periodListUrl, queryParameters: {'type': _type}).then((response) {
      setState(() {
        PeriodList periodList =
            new PeriodList.fromJson(jsonDecode(response.toString()));
        _periodList.addAll(periodList.items);
      });
    });
  }

  Widget _buildChildTiles(List<MagChild> periodList) {
    return ListView.builder(
        itemCount: periodList.length,
        itemBuilder: (context, i) {
          return PeriodItemWidget(periodList[i]);
        });
  }

  Future<void> _onRefresh() async {
    return _getPeriodList();
  }
}
