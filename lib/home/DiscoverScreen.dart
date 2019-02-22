import 'package:flutter/material.dart';
import 'package:myapp/widget/RefreshWithHttp.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DiscoverScreenState();
}

class DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new RefreshWithHttp(),
    );
  }
}