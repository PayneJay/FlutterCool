import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cool/widget/LoadingDialog.dart';
import 'package:flutter_cool/callback/DialogCallback.dart';

void showConfirmDialog(BuildContext context, String title, String content,
    DialogCallback callback) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return new CupertinoAlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                if (callback != null) {
                  callback.confirm();
                }
                Navigator.of(context).pop("点击了确定");
              },
              child: new Text(
                "确认",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop("点击了取消");
              },
              child: new Text("取消"),
            ),
          ],
        );
      });
}

void showProgress(BuildContext context) {
  showDialog<Null>(
      context: context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
          //调用对话框
          text: '正在加载...',
        );
      });
}
