import 'package:flutter/material.dart';

import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:fluwx/fluwx.dart';

// ignore: must_be_immutable
class SharePanel extends StatefulWidget {
  String _url;
  String _title;
  String _feedTitle;
  String _imageUrl;

  SharePanel(this._url, this._title, this._feedTitle, this._imageUrl);

  @override
  State<StatefulWidget> createState() {
    return SharePanelState();
  }
}

class SharePanelState extends State<SharePanel> {
  String _url;
  String _title;
  String _feedTitle;
  String _imageUrl;
  WeChatScene scene;

  @override
  void initState() {
    _url = widget._url;
    _title = widget._title;
    _feedTitle = widget._feedTitle;
    _imageUrl = widget._imageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildGrid();
  }

  Widget buildGrid() {
    return Container(
        child: GridView(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //每行三列
            childAspectRatio: 1.5,
          ),
          children: <Widget>[
            getImageWidget(
                'images/icon_socialize_wechat.png', WeChatScene.SESSION),
            getImageWidget(
                'images/icon_socialize_wxcircle.png', WeChatScene.TIMELINE),
            getImageWidget(
                'images/icon_socialize_fav.png', WeChatScene.FAVORITE),
            getImageWidget('images/icon_socialize_qq.png', WeChatScene.SESSION),
            getImageWidget(
                'images/icon_socialize_qzone.png', WeChatScene.SESSION),
            getImageWidget(
                'images/icon_socialize_sina.png', WeChatScene.SESSION)
          ],
        ),
        height: 200);
  }

  Widget getImageWidget(String imagePath, WeChatScene scene) {
    return GestureDetector(
        child: IconButton(
          icon: Image.asset(imagePath, width: 40, height: 40),
          padding: EdgeInsets.all(3),
          onPressed: null,
        ),
        onTap: () {
          handleShareChanged(scene);
          _shareWebPage();
        });
  }

  Future _shareText() async {
    fluwx.shareToWeChat(WeChatShareTextModel(
        text: "text from fluwx", transaction: "transaction}", scene: scene));
  }

  Future _shareImage() async {
    fluwx.shareToWeChat(fluwx.WeChatShareImageModel(
        image: _imageUrl,
        thumbnail: '',
        transaction: _imageUrl,
        scene: scene,
        description: "image"));
  }

  Future _shareWebPage() async {
    var model = fluwx.WeChatShareWebPageModel(
        webPage: _url,
        title: _title,
        thumbnail: _imageUrl,
        scene: scene,
        transaction: "hh");
    fluwx.shareToWeChat(model);
  }

  Future _shareMusic() async {
    var model = WeChatShareMusicModel(
        title: _title,
        description: _feedTitle,
        transaction: "music",
        musicUrl: 'https://music.163.com/#/song?id=436514312',
        musicLowBandUrl: 'https://music.163.com/#/song?id=436514312',
        scene: scene);

    fluwx.shareToWeChat(model);
  }

  Future _shareVideo() async {
    var model = fluwx.WeChatShareVideoModel(
        videoUrl: 'https://weibo.com/tv/v/HdIR7rTPR?fid=1034:4332706902024776',
        transaction: "video",
        videoLowBandUrl:
            'https://weibo.com/tv/v/HdIR7rTPR?fid=1034:4332706902024776',
        thumbnail: _imageUrl,
        description: _feedTitle,
        title: _title,
        scene: scene);
    fluwx.shareToWeChat(model);
  }

  Future _shareMiniProgram() async {
    var model = fluwx.WeChatShareMiniProgramModel(
        webPageUrl: _url,
        miniProgramType: fluwx.WXMiniProgramType.RELEASE,
        userName: "Flutter",
        title: _title,
        description: _feedTitle,
        thumbnail: _imageUrl);
    fluwx.shareToWeChat(model);
  }

  void handleShareChanged(fluwx.WeChatScene scene) {
    setState(() {
      this.scene = scene;
    });
  }
}
