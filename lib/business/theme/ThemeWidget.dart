import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/http/Http.dart';
import 'package:myapp/http/InterfaceService.dart';
import 'package:myapp/models/topicDirs.dart';
import 'package:myapp/models/topicGroup.dart';
import 'package:myapp/models/topicChild.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:myapp/business/theme/TopicDetailScreen.dart';

class ThemeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ThemeWidgetState();
}

class ThemeWidgetState extends State<ThemeWidget> {
  List<TopicGroup> _topicGroup = List();

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          new GroupItem(_topicGroup[index], context),
      itemCount: _topicGroup.length,
    );
  }

  @override
  void initState() {
    super.initState();
    _getTopicDirs();
  }

  void _getTopicDirs() async {
    await dio.get(topicDirUrl).then((response) {
      setState(() {
        TopicDirs topicDirs =
            new TopicDirs.fromJson(json.decode(response.toString()));
        _topicGroup = topicDirs.items;
      });
    });
  }
}

class GroupItem extends StatelessWidget {
  const GroupItem(this.group, this._context);

  final TopicGroup group;
  final BuildContext _context;

  Widget _buildGroupTiles(TopicGroup group) {
    if (group.items.isEmpty) return new ListTile(title: new Text(group.name));
    return new ExpansionTile(
      key: new PageStorageKey<TopicGroup>(group),
      title: new Text(group.name),
      children: group.items.map(_buildChildTiles).toList(),
    );
  }

  Widget _buildChildTiles(TopicChild child) {
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
        onTap: () {
          _goTopicDetail(child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildGroupTiles(group);
  }

  void _goTopicDetail(TopicChild child) {
    Navigator.of(_context).push(new MaterialPageRoute(builder: (context) {
      return new TopicDetailScreen(child.id);
    }));
  }
}

