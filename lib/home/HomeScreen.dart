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
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.collections_bookmark, color: Colors.white),
            onPressed: _randomWords.randomWordState.pushSaved,
          )
        ],
      ),
      body: _randomWords,
    );
  }
}
