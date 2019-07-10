import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/business/profile/ExamplePage.dart';

import 'UserProfilePage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          GestureDetector(
              child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: Colors.pinkAccent),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: _image == null
                                      ? NetworkImage(
                                          'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg')
                                      : FileImage(_image),
                                  fit: BoxFit.cover))),
                      new Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: new Text(
                          'FlutterCool',
                          style:
                              new TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      )
                    ],
                  )),
              onTap: () {
                _goUserProfile();
              }),
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
      return new ExamplePage();
    }));
  }

  _goUserProfile() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new UserProfilePage();
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
