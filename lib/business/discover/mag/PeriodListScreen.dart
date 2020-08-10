import 'package:flutter/material.dart';
import 'package:cool/models/magGroup.dart';
import 'package:cool/widget/EmptyWidget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:cool/http/Http.dart';
import 'package:cool/http/InterfaceService.dart';
import 'dart:convert';
import 'package:cool/models/periodList.dart';
import 'package:cool/models/magChild.dart';
import 'package:cool/widget/PeriodItemWidget.dart';

class PeriodListScreen extends StatefulWidget {
  final MagGroup _child;

  PeriodListScreen(this._child);

  @override
  State<StatefulWidget> createState() => PeriodListScreenState(_child);
}

class PeriodListScreenState extends State<PeriodListScreen> {
  final MagGroup _magGroup;
  var _type;
  List<MagChild> _periodList = List();

  PeriodListScreenState(this._magGroup);

  @override
  Widget build(BuildContext context) {
    _type = _magGroup.type;
    return Scaffold(
      appBar: AppBar(title: Text(_magGroup == null ? '' : _magGroup.name)),
      body: EasyRefresh(
        header: PhoenixHeader(),
        child: _periodList.length == 0
            ? EmptyWidget()
            : _buildChildTiles(_periodList),
        onRefresh: _onRefresh,
        firstRefresh: true,
        emptyWidget: EmptyWidget(),
      ),
    );
  }

  Future<void> _getPeriodList() async {
    await dio
        .get(periodListUrl, queryParameters: {'type': _type}).then((response) {
      setState(() {
        PeriodList periodList =
            PeriodList.fromJson(jsonDecode(response.toString()));
        _periodList.addAll(periodList.items);
      });
    });
  }

  Widget _buildChildTiles(List<MagChild> periodList) {
    return ListView.builder(
        itemCount: periodList.length,
        itemBuilder: (context, i) {
          return PeriodItemWidget(periodList[i], context);
        });
  }

  Future<void> _onRefresh() async {
    return _getPeriodList();
  }
}
