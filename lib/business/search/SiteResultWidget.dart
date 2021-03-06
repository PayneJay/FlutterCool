import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:myapp/business/site/SiteDetailScreen.dart';
import 'package:myapp/event/EventBus.dart';
import 'package:myapp/event/SearchEvent.dart';
import 'package:myapp/http/Http.dart';
import 'package:myapp/http/InterfaceService.dart';
import 'package:myapp/models/siteSearch.dart';
import 'package:myapp/models/site.dart';
import 'package:myapp/widget/EmptyWidget.dart';
import 'package:transparent_image/transparent_image.dart';

class SiteResultWidget extends StatefulWidget {
  final String _inputText;

  SiteResultWidget(this._inputText);

  @override
  State<StatefulWidget> createState() => SiteResultWidgetState(_inputText);
}

class SiteResultWidgetState extends State<SiteResultWidget> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  var _sites = new List<Site>();

  StreamSubscription<SearchEvent> subscription;

  String _keyWord;

  SiteResultWidgetState(this._keyWord);

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
            new SiteSearch.fromJson(json.decode(response.toString()));
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
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new SiteDetailScreen(sit.id);
    }));
  }

  Future<void> _onRefresh() async {
    _sites.clear();
    return _searchSites();
  }
}
