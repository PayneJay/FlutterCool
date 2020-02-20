import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cool/business/login/LoginPage.dart';
import 'package:cool/business/profile/ExamplePage.dart';
import 'package:cool/models/user.dart';
import 'package:cool/utils/Constants.dart';
import 'package:cool/utils/CommonUtil.dart';
import 'UserProfilePage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  File _image;
  String _nickName = 'Flutter';
  String _imgUrl =
      'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg';

  @override
  void initState() {
    getBool(USER_LOGIN_STATUS_KEY).then((value) {
      if (value != null && value) {
        getString(USER_INFO_KEY).then((value) {
          setState(() {
            if (value.isNotEmpty) {
              User user = User.fromJson(json.decode(value));
              _nickName = user.name;
              _imgUrl = user.profile;
            }
          });
        });
      }
    });

    super.initState();
  }

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
                                  width: 1, color: Colors.pinkAccent),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: _image == null
                                      ? NetworkImage(_imgUrl)
                                      : FileImage(_image),
                                  fit: BoxFit.cover))),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          _nickName,
                          style: TextStyle(fontSize: 18, color: Colors.black),
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
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: kTextTabBarHeight,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Center(
                                  child: Text(
                                    item.title,
                                    style: TextStyle(fontSize: 16),
                                  ),
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ExamplePage();
    }));
  }

  _goUserProfile() async {
    getBool(USER_LOGIN_STATUS_KEY).then((value) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        if (value != null && value) {
          return UserProfilePage();
        }
        return LoginPage();
      }));
    });
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
