import 'package:flutter/material.dart';
import 'package:myapp/widget/LoadingDialog.dart';

void showProgress(BuildContext context) {
  showDialog<Null>(
      context: context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
          //调用对话框
          text: '正在获取详情...',
        );
      });
}
