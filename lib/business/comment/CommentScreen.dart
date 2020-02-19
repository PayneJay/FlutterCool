import 'package:flutter/material.dart';
import 'package:cool/widget/EmptyWidget.dart';

class CommentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommentScreenState();
}

class CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('评论')),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.insert_comment),
          onPressed: () {
            print('FloatingActionButton');
          },
        ),
        body: EmptyWidget());
  }
}
