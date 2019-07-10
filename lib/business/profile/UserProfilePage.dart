import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new UserProfileState();
}

class UserProfileState extends State<UserProfilePage> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('编辑信息'), actions: <Widget>[
        IconButton(icon: Icon(Icons.power_settings_new), onPressed: _logOut)
      ]),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 16.0),
        child: Center(
          child: Column(
            //动态创建一个List<Widget>
            children: items.map((item) => getItemWidget(item)).toList(),
          ),
        ),
      ),
    );
  }

  Widget getItemWidget(ProfileItem item) {
    if (item.key == 0) {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(left: 15),
                child: new Text(
                  item.label,
                  style: new TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              GestureDetector(
                child: Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.pinkAccent),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: _image == null
                                ? NetworkImage(item.value)
                                : FileImage(_image),
                            fit: BoxFit.cover))),
                onTap: () {
                  _selectAvatar();
                },
              )
            ],
          ),
          Divider(
            color: Colors.black12,
          )
        ],
      );
    }

    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  item.label,
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                    child: Text(
                      item.value,
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                    onTap: () {
                      _onItemClick(item);
                    })
              ],
            )),
        Divider(
          color: Colors.black12,
        )
      ],
    );
  }

  void _onItemClick(ProfileItem item) {
    switch (item.key) {
      case 0:
        _selectAvatar();
        break;
    }
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

void _logOut() {}

enum ConfirmAction { GALLERY, CAMERA }

class ProfileItem {
  const ProfileItem({this.label, this.value, this.key});

  final String label;
  final String value;
  final int key;
}

const List<ProfileItem> items = const <ProfileItem>[
  const ProfileItem(
      label: '头像',
      value: 'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg',
      key: 0),
  const ProfileItem(label: '用户名', value: 'Flutter', key: 1),
  const ProfileItem(label: '登录邮箱', value: 'developerBoy@163.com', key: 2),
  const ProfileItem(label: '密码', value: '', key: 3),
  const ProfileItem(label: '微博', value: '', key: 4),
  const ProfileItem(label: 'QQ', value: '', key: 5),
  const ProfileItem(label: '微信', value: '', key: 6)
];
