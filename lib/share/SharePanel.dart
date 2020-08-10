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
          padding: const EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //每行三列
            childAspectRatio: 1.5,
          ),
          children: <Widget>[
            getImageWidget(
                'images/icon_socialize_wechat.png', WeChatScene.SESSION, '微信'),
            getImageWidget('images/icon_socialize_wxcircle.png',
                WeChatScene.TIMELINE, '朋友圈'),
            getImageWidget(
                'images/icon_socialize_fav.png', WeChatScene.FAVORITE, '收藏'),
            getImageWidget(
                'images/icon_socialize_qq.png', WeChatScene.SESSION, 'QQ'),
            getImageWidget(
                'images/icon_socialize_qzone.png', WeChatScene.SESSION, 'QQ空间'),
            getImageWidget(
                'images/icon_socialize_sina.png', WeChatScene.SESSION, '微博'),
          ],
        ),
        height: 200);
  }

  Widget getImageWidget(
      String imagePath, WeChatScene scene, String channelName) {
    return GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Image.asset(imagePath, width: 40, height: 40),
              padding: EdgeInsets.all(3),
              onPressed: null,
            ),
            Text(channelName)
          ],
        ),
        onTap: () {
          handleShareChanged(scene);
          _shareWebPage();
        });
  }

  Future _shareText() async {
    fluwx.shareToWeChat(WeChatShareTextModel("text from fluwx", scene: scene));
  }

  Future _shareImage() async {
    fluwx.shareToWeChat(
      fluwx.WeChatShareImageModel(WeChatImage.network(_imageUrl),
          thumbnail: WeChatImage.asset('images/app_logo.png'),
          description: "image"),
    );
  }

  Future _shareWebPage() async {
    var model = fluwx.WeChatShareWebPageModel(
      _url,
      title: _title,
      thumbnail: WeChatImage.asset('images/app_logo.png'),
      scene: scene,
    );
    fluwx.shareToWeChat(model);
  }

  Future _shareMusic() async {
    var model = WeChatShareMusicModel(
        title: _title,
        description: _feedTitle,
        musicUrl: 'https://music.163.com/#/song?id=436514312',
        musicLowBandUrl: 'https://music.163.com/#/song?id=436514312',
        thumbnail: WeChatImage.asset('images/app_logo.png'),
        scene: scene);

    fluwx.shareToWeChat(model);
  }

  Future _shareVideo() async {
    var model = fluwx.WeChatShareVideoModel(
        videoUrl: 'https://weibo.com/tv/v/HdIR7rTPR?fid=1034:4332706902024776',
        videoLowBandUrl:
            'https://weibo.com/tv/v/HdIR7rTPR?fid=1034:4332706902024776',
        thumbnail: WeChatImage.asset('images/app_logo.png'),
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
      thumbnail: WeChatImage.asset('images/app_logo.png'),
    );
    fluwx.shareToWeChat(model);
  }

  void handleShareChanged(fluwx.WeChatScene scene) {
    setState(() {
      this.scene = scene;
    });
  }
}
