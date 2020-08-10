import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:cool/business/site/SiteDetailScreen.dart';
import 'package:cool/event/EventBus.dart';
import 'package:cool/event/SearchEvent.dart';
import 'package:cool/http/Http.dart';
import 'package:cool/http/InterfaceService.dart';
import 'package:cool/models/siteSearch.dart';
import 'package:cool/models/site.dart';
import 'package:cool/widget/EmptyWidget.dart';
import 'package:transparent_image/transparent_image.dart';

class SiteResultWidget extends StatefulWidget {
  final String _inputText;

  SiteResultWidget(this._inputText);

  @override
  State<StatefulWidget> createState() => SiteResultWidgetState(_inputText);
}

class SiteResultWidgetState extends State<SiteResultWidget> {
  var _sites = List<Site>();

  StreamSubscription<SearchEvent> subscription;

  String _keyWord;

  SiteResultWidgetState(this._keyWord);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: ClassicalHeader(
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        infoColor: Colors.black54,
      ),
      footer: ClassicalFooter(
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        infoColor: Colors.black54,
      ),
      child: _buildListView(),
      onRefresh: _onRefresh,
      firstRefresh: true,
      emptyWidget: EmptyWidget(),
    );
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
                              image: _sites[index] == null
                                  ? 'https://avatars1.githubusercontent.com/u/14101776?s=200&v=4'
                                  : _sites[index].image),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(_sites[index].name),
                    )
                  ]),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _onButtonClick(_sites[index]))
                ],
              ),
              onTap: () {
                _onItemClick(_sites[index]);
              });
        },
        separatorBuilder: (context, index) {
          return Divider(color: Colors.black12);
        },
        itemCount: _sites.length);
  }

  Future _searchSites() async {
    await dio
        .get(siteSearchUrl, queryParameters: {"kw": _keyWord}).then((response) {
      setState(() {
        SiteSearch result =
            SiteSearch.fromJson(json.decode(response.toString()));
        _sites.addAll(result.items);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    subscription = eventBus.on<SearchEvent>().listen((event) {
      setState(() {
        _keyWord = event.keyWord;
        _onRefresh();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  _onButtonClick(Site sit) {}

  void _onItemClick(Site sit) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SiteDetailScreen(sit.id);
    }));
  }

  Future<void> _onRefresh() async {
    _sites.clear();
    return _searchSites();
  }
}
