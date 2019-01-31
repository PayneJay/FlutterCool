import 'package:flutter/material.dart';
import 'package:myapp/widget/RatingPage.dart';

class EmailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EmailScreenState();
}

class EmailScreenState extends State<EmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email'),
      ),
      body: new RatingPage(),
    );
  }
}
