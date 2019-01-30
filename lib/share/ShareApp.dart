import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:sy_flutter_wechat/sy_flutter_wechat.dart';
import 'package:flutter_wechat/flutter_wechat.dart';

class ShareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Share",
      home: ShareAppState(),
    );
  }
}

class ShareAppState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Sharing();
  }
}

Widget buildGrid() {
  return new GridView.extent(
    maxCrossAxisExtent: 150.0,
    padding: const EdgeInsets.all(4.0),
    mainAxisSpacing: 5.0,
    crossAxisSpacing: 5.0,
    children: _buildGridTileList(30),
  );
}

Widget buildShareList() {
  return new ListView(
    padding: EdgeInsets.all(8.0),
    children: <Widget>[
      RaisedButton(
        child: Text('分享文字'),
        onPressed: () async {
          bool res = await SyFlutterWechat.shareText('hello world',
              shareType: SyShareType.session);
          print('分享文字：' + res.toString());
        },
      ),
      RaisedButton(
        child: Text('分享图片'),
        onPressed: () async {
          bool res = await SyFlutterWechat.shareImage(
              'https://avatars0.githubusercontent.com/u/10024776',
              shareType: SyShareType.timeline);
          print('分享图片：' + res.toString());
        },
      ),
      RaisedButton(
        child: Text('分享网页'),
        onPressed: () async {
          bool res = await SyFlutterWechat.shareWebPage(
              '标题',
              '描述',
              'https://avatars0.githubusercontent.com/u/10024776',
              'http://www.example.com',
              shareType: SyShareType.session);
          print('分享网页：' + res.toString());
        },
      ),
      RaisedButton(
        child: Text('支付'),
        onPressed: () async {
          String payInfo =
              '{"appid":"wxf9909bde17439ac2","partnerid":"1518469211","prepayid":"wx120649521695951d501636f91748325073","package":"Sign=WXPay","noncestr":"1541976592","timestamp":"1541976592","sign":"E760C99A1A981B9A7D8F17B08EF60FCC"}';
          SyPayResult payResult = await SyFlutterWechat.pay(
              SyPayInfo.fromJson(json.decode(payInfo)));
          print(payResult);
        },
      ),
    ],
  );
}

List<Stack> _buildGridTileList(int count) {
  return new List<Stack>.generate(
      count,
      (int index) => new Stack(
            alignment: const Alignment(0.5, 0.5),
            children: <Widget>[
              new CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://ps.ssl.qhmsg.com/bdr/1080__/t013213f30f7a50af19.jpg'),
                radius: 50,
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.black45,
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(8.0)),
                ),
                margin: const EdgeInsets.all(4.0),
                child: new Text(
                  'Mia B',
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ));
}

class Sharing extends State<ShareAppState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: testShare)
        ],
      ),
      body: new Center(
        child: buildShareList(),
      ),
    );
  }

  Future<void> testShare() async {
    // 分享
    await FlutterWechat.shareText(
      text: "我在测试flutter的分享，求成功！",
      type: 0,
    ).then((state) {
      print(state);
    }); //文字分享 type 0 聊天页面 1 朋友圈
    // await FlutterWechat.shareImage(
    //   imgUrl: "https://ps.ssl.qhmsg.com/bdr/1080__/t013213f30f7a50af19.jpg",
    //   type: 0,
    // ).then((state) {
    //   print(state);
    // });
    // await FlutterWechat.shareMusic(
    //   imgUrl: "https://ps.ssl.qhmsg.com/bdr/1080__/t013213f30f7a50af19.jpg",
    //   musicUrl: "https://music.163.com/#/song?id=436514312",
    //   title: "成都",
    //   description: "赵雷-成都",
    //   musicDataUrl: "",
    //   musicLowBandDataUrl: "",
    //   musicLowBandUrl: "",
    //   type: 0,
    // ).then((state) {
    //   print(state);
    // });
    // await FlutterWechat.shareVideo(
    //   imgUrl: "https://ps.ssl.qhmsg.com/bdr/1080__/t013213f30f7a50af19.jpg",
    //   videoUrl: "https://weibo.com/tv/v/HdIR7rTPR?fid=1034:4332706902024776",
    //   title: "火箭vs猛龙",
    //   description: "登哥赛后采访……",
    //   videoLowBandUrl: "",
    //   type: 0,
    // ).then((state) {
    //   print(state);
    // });
    // await FlutterWechat.shareWebPage(
    //   imgUrl: "https://ps.ssl.qhmsg.com/bdr/1080__/t013213f30f7a50af19.jpg",
    //   webpageUrl: "",
    //   title: "",
    //   description: "",
    //   type: 0,
    // ).then((state) {
    //   print(state);
    // });
  }
}
