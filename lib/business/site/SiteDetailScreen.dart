import 'package:flutter/material.dart';
import 'package:myapp/widget/SiteDetailWidget.dart';
import 'package:myapp/http/Http.dart';
import 'package:myapp/models/siteDetail.dart';
import 'dart:convert';

class SiteDetailScreen extends StatefulWidget {
  final String _id;

  SiteDetailScreen(this._id);

  @override
  State<StatefulWidget> createState() => SiteDetailState(_id);
}

class SiteDetailState extends State<SiteDetailScreen> {
  String _id;
  SiteDetail _siteDetail;

  SiteDetailState(this._id);

  @override
  Widget build(BuildContext context) {
    return new SiteDetailWidget(_siteDetail);
  }

  @override
  void initState() {
    super.initState();
    _getTopics();
  }

  void _getTopics() async {
    dio.get('/api/sites/$_id.json', queryParameters: {
      'pn': 0,
      'size': 30,
      'is_pad': 1,
    }).then((response) {
      setState(() {
        _siteDetail = SiteDetail.fromJson(json.decode(response.toString()));
      });
    });
  }
}
