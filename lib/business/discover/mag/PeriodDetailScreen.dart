import 'package:flutter/material.dart';
import 'package:myapp/models/magChild.dart';
import 'package:myapp/models/magDetail.dart';
import 'package:myapp/models/magDetailGroup.dart';
import 'package:myapp/widget/EmptyWidget.dart';
import 'package:myapp/widget/MagDetailChildItemWidget.dart';
import 'package:myapp/http/Http.dart';
import 'package:myapp/http/InterfaceService.dart';
import 'dart:convert';

class PeriodDetailScreen extends StatefulWidget {
  final MagChild _magChild;

  const PeriodDetailScreen(this._magChild);

  @override
  State<StatefulWidget> createState() => new PeriodDetailScreenState();
}

class PeriodDetailScreenState extends State<PeriodDetailScreen>
    with TickerProviderStateMixin {
  List<MagDetailGroup> _magGroup = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(widget._magChild.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      )),
                  background: Image.network(
                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531798262708&di=53d278a8427f482c5b836fa0e057f4ea&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F342ac65c103853434cc02dda9f13b07eca80883a.jpg",
                    fit: BoxFit.fill,
                  )),
            ),
          ];
        },
        body: new ListView.builder(
            itemCount: _magGroup.length,
            itemBuilder: (context, i) {
              return _magGroup.length == 0
                  ? EmptyWidget()
                  : _buildExpandTiles(_magGroup[i]);
            }),
      ),
    );
  }

  Widget _buildExpandTiles(MagDetailGroup group) {
    if (group == null) return new ListTile(title: new Text('must not be null'));
    return Column(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
            color: Color(0x11000000),
            child: Text(group.name,
                style: TextStyle(fontSize: 16, color: Colors.blueAccent))),
        Container(
          child: ListView.builder(
              itemCount: group.items.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return MagDetailChildItemWidget(group.items[i], context);
              }),
          margin: const EdgeInsets.only(top: 10),
        )
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
        MagDetail magDirs =
            new MagDetail.fromJson(jsonDecode(response.toString()));
        _magGroup = magDirs.items;
      });
    });
  }
}
