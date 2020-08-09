import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:cool/business/theme/TopicDetailScreen.dart';
import 'package:cool/event/EventBus.dart';
import 'package:cool/event/SearchEvent.dart';
import 'package:cool/http/Http.dart';
import 'package:cool/http/InterfaceService.dart';
import 'package:cool/models/topicSearch.dart';
import 'package:cool/models/topicChild.dart';
import 'package:cool/widget/EmptyWidget.dart';
import 'package:transparent_image/transparent_image.dart';

class TopicResultWidget extends StatefulWidget {
  final String _inputText;

  TopicResultWidget(this._inputText);

  @override
  State<StatefulWidget> createState() => TopicResultWidgetState(_inputText);
}

class TopicResultWidgetState extends State<TopicResultWidget> {
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  var _topics = List<TopicChild>();

  StreamSubscription<SearchEvent> subscription;

  String _keyWord;

  TopicResultWidgetState(this._keyWord);

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
        onRefresh: _onRefresh,
        autoLoad: true,
        firstRefresh: true,
        emptyWidget: EmptyWidget());
  }

  Widget _buildListView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
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
    await dio.get(topicSearchUrl, queryParameters: {"kw": _keyWord}).then(
        (response) {
      setState(() {
        TopicSearch result =
            TopicSearch.fromJson(json.decode(response.toString()));
        _topics.addAll(result.topics);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    subscription = eventBus.on<SearchEvent>().listen((event) {
      setState(() {
        _keyWord = event.keyWord;
        _searchTopics();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  void _onItemClick(TopicChild topic) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return TopicDetailScreen(topic.id);
    }));
  }

  Future<void> _onRefresh() async {
    _topics.clear();
    return _searchTopics();
  }
}
