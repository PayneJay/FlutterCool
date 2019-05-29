import 'package:flutter/material.dart';
import 'package:myapp/business/theme/ThemePage.dart';

class ThemeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ThemeScreenState();
}

class ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ThemePage(),
    );
  }
}
