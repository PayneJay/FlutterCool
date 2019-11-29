import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewWidget extends StatefulWidget {
  final String _newsUrl;
  final String _title;

  WebViewWidget(this._newsUrl, this._title);

  @override
  State<StatefulWidget> createState() => WebViewWidgetState();
}

class WebViewWidgetState extends State<WebViewWidget> {
  // 标记是否是加载中
  bool loading = true;

  // 标记当前页面是否是我们自定义的回调页面
  bool isLoadingCallbackPage = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  // URL变化监听器
  StreamSubscription<String> onUrlChanged;

  // WebView加载状态变化监听器
  StreamSubscription<WebViewStateChanged> onStateChanged;

  // 插件提供的对象，该对象用于WebView的各种操作
  FlutterWebviewPlugin flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      // state.type是一个枚举类型，取值有：WebViewState.shouldStart, WebViewState.startLoad, WebViewState.finishLoad
      switch (state.type) {
        case WebViewState.shouldStart:
          // 准备加载
          setState(() {
            loading = true;
          });
          break;
        case WebViewState.startLoad:
          // 开始加载
          break;
        case WebViewState.finishLoad:
          // 加载完成
          setState(() {
            loading = false;
          });
          if (isLoadingCallbackPage) {
            // 当前是回调页面，则调用js方法获取数据
            parseResult();
          }
          break;
        case WebViewState.abortLoad:
          // TODO: Handle this case.
          break;
      }
    });

    onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          //这里拦截url变化，可以实现点击号码拨号
          if (url.startsWith('tel:')) {
            print(url);
          }
        });
      }
    });
  }

  // 解析WebView中的数据
  void parseResult() {
//    flutterWebViewPlugin.evalJavascript("get();").then((result) {
//      // result json字符串，包含token信息
//
//    });
  }

  @override
  Widget build(BuildContext context) {
    // WebviewScaffold是插件提供的组件，用于在页面上显示一个WebView并加载URL
    return WebviewScaffold(
//      key: scaffoldKey,
      url: widget._newsUrl,
      // 登录的URL
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(widget._title,
            maxLines: 1,
            textAlign: TextAlign.end,
            style: TextStyle(color: Colors.white)),
      ),
      withZoom: true,
      // 允许网页缩放
      withLocalStorage: true,
      // 允许LocalStorage
      withJavascript: true, // 允许执行js代码
    );
  }

  @override
  void dispose() {
    // 回收相关资源
    // Every listener should be canceled, the same should be done with this stream.
    onUrlChanged.cancel();
    onStateChanged.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }
}
