import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cool/http/Http.dart';
import 'package:flutter_cool/http/InterfaceService.dart';
import 'package:flutter_cool/models/topicDirs.dart';
import 'package:flutter_cool/models/topicGroup.dart';
import 'package:flutter_cool/models/topicChild.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_cool/business/theme/TopicDetailScreen.dart';

class ThemeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ThemeWidgetState();
}

class ThemeWidgetState extends State<ThemeWidget> {
  List<TopicGroup> _topicGroup = List();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          GroupItem(_topicGroup[index], context),
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
            TopicDirs.fromJson(json.decode(response.toString()));
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
    if (group.items.isEmpty) return ListTile(title: Text(group.name));
    return ExpansionTile(
      key: PageStorageKey<TopicGroup>(group),
      title: Text(group.name),
      children: group.items.map(_buildChildTiles).toList(),
    );
  }

  Widget _buildChildTiles(TopicChild child) {
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
    Navigator.of(_context).push(MaterialPageRoute(builder: (context) {
      return TopicDetailScreen(child.id);
    }));
  }
}
