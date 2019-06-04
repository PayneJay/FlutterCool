import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:myapp/business/theme/TopicDetailScreen.dart';
import 'package:myapp/http/Http.dart';
import 'package:myapp/http/InterfaceService.dart';
import 'package:myapp/models/topicSearch.dart';
import 'package:myapp/models/topicChild.dart';
import 'package:myapp/widget/EmptyWidget.dart';
import 'package:transparent_image/transparent_image.dart';

class TopicResultWidget extends StatefulWidget {
  final String _inputText;

  TopicResultWidget(this._inputText);

  @override
  State<StatefulWidget> createState() => TopicResultWidgetState();
}

class TopicResultWidgetState extends State<TopicResultWidget> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  var _topics = new List<TopicChild>();

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        key: _easyRefreshKey,
        behavior: ScrollOverBehavior(),
        refreshHeader: ClassicsHeader(
          key: _headerKey,
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          moreInfoColor: Colors.black54,
          showMore: true,
        ),
        refreshFooter: ClassicsFooter(
          key: _footerKey,
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          moreInfoColor: Colors.black54,
          showMore: true,
        ),
        child: _buildListView(),
        onRefresh: _searchTopics,
        autoLoad: true,
        firstRefresh: true,
        emptyWidget: new EmptyWidget());
  }

  Widget _buildListView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: ClipOval(
                        child: FadeInImage.memoryNetwork(
                            width: 25,
                            height: 25,
                            placeholder: kTransparentImage,
                            image: _topics[index] == null
                                ? 'https://avatars1.githubusercontent.com/u/14101776?s=200&v=4'
                                : _topics[index].image),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(_topics[index].name),
                  )
                ]),
                IconButton(icon: Icon(Icons.add), onPressed: null)
              ],
            ),
            onTap: () {
              _onItemClick(_topics[index]);
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(color: Colors.black12);
        },
        itemCount: _topics.length);
  }

  Future _searchTopics() async {
    await dio.get(topicSearchUrl,
        queryParameters: {"kw": widget._inputText}).then((response) {
      setState(() {
        TopicSearch result =
            new TopicSearch.fromJson(json.decode(response.toString()));
        _topics.addAll(result.topics);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _searchTopics();
  }

  void _onItemClick(TopicChild topic) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new TopicDetailScreen(topic.id);
    }));
  }
}
