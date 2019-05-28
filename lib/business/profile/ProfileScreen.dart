import 'package:flutter/material.dart';
import 'package:myapp/widget/RatingPage.dart';
import 'package:myapp/business/profile/UserEditPage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                new GestureDetector(
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(
                      "https://p1.ssl.qhimgs1.com/bdr/576__/t0192dd8448f034a631.jpg",
                    ),
                  ),
                  onTap: () {
                    _selectAvatar();
                  },
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: new Text(
                    'FlutterCool',
                    style: new TextStyle(fontSize: 18, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: items
                .map((item) => Column(
                      children: <Widget>[
                        GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: kTextTabBarHeight,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Text(
                                  item.title,
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            _onItemClick(item.id);
                          },
                        ),
                        Divider(
                          height: 0,
                          color: Colors.black12,
                        )
                      ],
                    ))
                .toList(),
          )
        ],
      ),
    );
  }

  _onItemClick(int id) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new RatingPage();
    }));
  }

  void _selectAvatar() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new UserEditPage();
    }));
  }
}

class ListItem {
  const ListItem({this.title, this.id});

  final String title;
  final int id;
}

const List<ListItem> items = const <ListItem>[
  const ListItem(title: '我的待读', id: 1),
  const ListItem(title: '我的收藏', id: 2),
  const ListItem(title: '我的推刊', id: 3),
  const ListItem(title: '消息通知', id: 4),
  const ListItem(title: '阅读历史', id: 5),
  const ListItem(title: '夜间模式', id: 6),
  const ListItem(title: '鼓励一顿', id: 7),
  const ListItem(title: '离线阅读', id: 8),
  const ListItem(title: '检查更新', id: 9),
  const ListItem(title: '意见反馈', id: 10),
  const ListItem(title: '关于我们', id: 11),
];
