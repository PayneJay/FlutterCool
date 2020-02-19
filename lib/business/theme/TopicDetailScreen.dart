import 'package:flutter/material.dart';
import 'package:flutter_cool/widget/TopicDetailWidget.dart';
import 'package:flutter_cool/http/Http.dart';
import 'package:flutter_cool/models/topicDetail.dart';
import 'dart:convert';

class TopicDetailScreen extends StatefulWidget {
  final num _id;

  TopicDetailScreen(this._id);

  @override
  State<StatefulWidget> createState() => TopicDetailState(_id);
}

class TopicDetailState extends State<TopicDetailScreen> {
  num _id;
  TopicDetail _topicDetail;

  TopicDetailState(this._id);

  @override
  Widget build(BuildContext context) {
    return TopicDetailWidget(_topicDetail);
  }

  @override
  void initState() {
    super.initState();
    _getTopics();
  }

  void _getTopics() async {
    dio.get('/api/topics/$_id.json', queryParameters: {
      'pn': 0,
      'lang': 1,
      'st': 0,
      'size': 30,
      'is_pad': 1,
    }).then((response) {
      setState(() {
        _topicDetail = TopicDetail.fromJson(json.decode(response.toString()));
      });
    });
  }
}
