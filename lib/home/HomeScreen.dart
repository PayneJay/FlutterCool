import 'package:flutter/material.dart';
import 'package:myapp/widget/RandomWords.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  RandomWords _randomWords = new RandomWords();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _randomWords,
    );
  }
}
