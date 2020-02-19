import 'package:flutter/material.dart';
import 'package:flutter_cool/business/site/SiteListWidget.dart';

class SiteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SiteScreenState();
}

class SiteScreenState extends State<SiteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SiteListWidget(),
    );
  }
}
