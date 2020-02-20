import 'package:flutter/material.dart';
import 'package:cool/models/magChild.dart';
import 'package:cool/models/magDetail.dart';
import 'package:cool/models/magDetailGroup.dart';
import 'package:cool/widget/EmptyWidget.dart';
import 'package:cool/widget/MagDetailChildItemWidget.dart';
import 'package:cool/http/Http.dart';
import 'package:cool/http/InterfaceService.dart';
import 'dart:convert';

class PeriodDetailScreen extends StatefulWidget {
  final MagChild _magChild;

  const PeriodDetailScreen(this._magChild);

  @override
  State<StatefulWidget> createState() => PeriodDetailScreenState();
}

class PeriodDetailScreenState extends State<PeriodDetailScreen>
    with TickerProviderStateMixin {
  List<MagDetailGroup> _magGroup = List();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget._magChild.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              background: Image.network(
                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531798262708&di=53d278a8427f482c5b836fa0e057f4ea&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F342ac65c103853434cc02dda9f13b07eca80883a.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),

          ///List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                //创建列表项
                return Container(
                  alignment: Alignment.center,
                  child: _buildExpandTiles(_magGroup[index]),
                );
              },
              childCount: _magGroup.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandTiles(MagDetailGroup group) {
    if (group == null) return ListTile(title: Text('must not be null'));
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          color: Color(0x11000000),
          child: Text(
            group.name,
            style: TextStyle(fontSize: 16, color: Colors.blueAccent),
          ),
        ),
        ListView.builder(
          itemCount: group.items.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            return MagDetailChildItemWidget(group.items[i], context);
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    _getMagDetail();
    super.initState();
  }

  Future _getMagDetail() async {
    var magChild = widget._magChild;
    await dio.get(magDetailUrl, queryParameters: {
      'id': magChild == null ? '' : magChild.id,
      'type': magChild == null ? 0 : magChild.type
    }).then((response) {
      setState(() {
        MagDetail magDirs = MagDetail.fromJson(jsonDecode(response.toString()));
        _magGroup = magDirs.items;
      });
    });
  }
}
