import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cool/business/site/SiteDetailScreen.dart';
import 'package:cool/http/Http.dart';
import 'package:cool/http/InterfaceService.dart';
import 'package:cool/models/siteDirs.dart';
import 'package:cool/models/siteGroup.dart';
import 'package:cool/models/siteChild.dart';
import 'package:transparent_image/transparent_image.dart';

class SiteListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SiteListWidgetState();
}

class SiteListWidgetState extends State<SiteListWidget> {
  List<SiteGroup> _siteGroup = List();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          GroupItem(_siteGroup[index], context),
      itemCount: _siteGroup.length,
    );
  }

  @override
  void initState() {
    super.initState();
    _getSiteDirs();
  }

  void _getSiteDirs() async {
    await dio.get(siteDirUrl).then((response) {
      setState(() {
        SiteDirs siteDirs = SiteDirs.fromJson(json.decode(response.toString()));
        _siteGroup = siteDirs.items;
      });
    });
  }
}

class GroupItem extends StatelessWidget {
  const GroupItem(this.group, this._context);

  final BuildContext _context;
  final SiteGroup group;

  Widget _buildGroupTiles(SiteGroup group) {
    if (group.items.isEmpty) return ListTile(title: Text(group.name));
    return ExpansionTile(
      key: PageStorageKey<SiteGroup>(group),
      title: Text(group.name),
      children: group.items.map(_buildChildTiles).toList(),
    );
  }

  Widget _buildChildTiles(SiteChild child) {
    if (child == null) return ListTile(title: Text('must not be null'));
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        title: Row(
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
        onTap: () {
          _goSiteDetail(child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildGroupTiles(group);
  }

  void _goSiteDetail(SiteChild child) {
    Navigator.of(_context).push(MaterialPageRoute(builder: (context) {
      return SiteDetailScreen(child.id);
    }));
  }
}
