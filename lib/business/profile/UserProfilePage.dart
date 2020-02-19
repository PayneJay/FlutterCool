import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_cool/models/user.dart';
import 'package:flutter_cool/utils/CommonUtil.dart';
import 'package:flutter_cool/utils/Constants.dart';
import 'package:flutter_cool/utils/DialogUtil.dart';
import 'package:flutter_cool/callback/DialogCallback.dart';

class UserProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserProfileState();
}

class UserProfileState extends State<UserProfilePage>
    implements DialogCallback {
  File _image;
  List<ProfileItem> items = <ProfileItem>[
    ProfileItem(
        label: '头像',
        value: 'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg',
        key: 0),
    ProfileItem(label: '用户名', value: 'Flutter', key: 1),
    ProfileItem(label: '登录邮箱', value: 'developerBoy@163.com', key: 2),
    ProfileItem(label: '密码', value: '', key: 3),
    ProfileItem(label: '微博', value: '', key: 4),
    ProfileItem(label: 'QQ', value: '', key: 5),
    ProfileItem(label: '微信', value: '', key: 6)
  ];

  @override
  void initState() {
    getBool(USER_LOGIN_STATUS_KEY).then((value) {
      if (value != null && value) {
        getString(USER_INFO_KEY).then((value) {
          if (value.isNotEmpty) {
            User user = User.fromJson(json.decode(value));
            setUserInfo(user);
          }
        });
      }
    });

    super.initState();
  }

  setUserInfo(User user) {
    setState(() {
      for (ProfileItem item in items) {
        switch (item.key) {
          case 0:
            item.value = user.profile;
            break;
          case 1:
            item.value = user.name;
            break;
          case 2:
            item.value = user.email;
            break;
          case 3:
            item.value = '修改密码';
            break;
          case 4:
            item.value = user.weibo_name;
            break;
          case 5:
            item.value = user.qq_name;
            break;
          case 6:
            item.value = user.weixin_name;
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  item.label,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              GestureDetector(
                child: Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.pinkAccent),
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
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
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

  void _logOut() {
    showConfirmDialog(context, '确认退出？', '', this);
  }

  @override
  void cancel() {
    // TODO: implement cancel
  }

  @override
  void confirm() {
    saveString(USER_INFO_KEY, json.encode(''));
    saveBool(USER_LOGIN_STATUS_KEY, false);
    Navigator.pop(context);
  }
}

enum ConfirmAction { GALLERY, CAMERA }

class ProfileItem {
  ProfileItem({this.label, this.value, this.key});

  String label;
  String value;
  int key;
}
