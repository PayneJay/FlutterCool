import 'package:flutter/material.dart';
import 'package:myapp/business/site/SitePage.dart';

class SiteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SiteScreenState();
}

class SiteScreenState extends State<SiteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SitePage(),
    );
  }
}
