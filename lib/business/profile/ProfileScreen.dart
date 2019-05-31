import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                new GestureDetector(
                  child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: Colors.pinkAccent),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: _image == null
                                  ? NetworkImage(
                                      'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg')
                                  : FileImage(_image),
                              fit: BoxFit.cover))),
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
    print('go---------$id');
  }

  void _selectAvatar() {
    _asyncConfirmDialog(context);
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('设置头像'),
          actions: <Widget>[
            FlatButton(
              child: const Text('相册'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.GALLERY);
                _openGallery();
              },
            ),
            FlatButton(
              child: const Text('拍照'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CAMERA);
                _takePhoto();
              },
            )
          ],
        );
      },
    );
  }

  /*拍照*/
  Future _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  /*相册*/
  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}

enum ConfirmAction { GALLERY, CAMERA }

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
