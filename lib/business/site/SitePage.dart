import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/http/Http.dart';
import 'package:myapp/http/InterfaceService.dart';
import 'package:myapp/models/siteDirs.dart';
import 'package:myapp/models/siteGroup.dart';
import 'package:myapp/models/siteChild.dart';
import 'package:transparent_image/transparent_image.dart';

class SitePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SitePageState();
}

class SitePageState extends State<SitePage> {
  List<SiteGroup> _siteGroup = List();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          new GroupItem(_siteGroup[index]),
      itemCount: _siteGroup.length,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSiteDirs();
  }

  void _getSiteDirs() async {
    await dio.get(siteDirUrl).then((response) {
      setState(() {
        SiteDirs siteDirs =
            new SiteDirs.fromJson(json.decode(response.toString()));
        _siteGroup = siteDirs.items;
      });
    });
  }
}

class GroupItem extends StatelessWidget {
  const GroupItem(this.group);

  final SiteGroup group;

  Widget _buildGroupTiles(SiteGroup group) {
    if (group.items.isEmpty) return new ListTile(title: new Text(group.name));
    return new ExpansionTile(
      key: new PageStorageKey<SiteGroup>(group),
      title: new Text(group.name),
      children: group.items.map(_buildChildTiles).toList(),
    );
  }

  Widget _buildChildTiles(SiteChild child) {
    if (child == null) return new ListTile(title: new Text('must not be null'));
    return new Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        title: new Row(
          children: <Widget>[
            ClipOval(
              child: FadeInImage.memoryNetwork(
                  width: 25,
                  height: 25,
                  placeholder: kTransparentImage,
                  image: child.image == null
                      ? 'https://avatars1.githubusercontent.com/u/14101776?s=200&v=4'
                      : child.image),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(child.name),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildGroupTiles(group);
  }
}
