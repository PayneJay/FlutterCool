import 'dart:async';

import 'package:flutter/material.dart';
import 'SearchResultWidget.dart';
import 'package:flutter_cool/event/EventBus.dart';
import 'package:flutter_cool/event/SearchEvent.dart';
import 'package:flutter_cool/event/SearchChangeEvent.dart';

class SearchScreen extends StatefulWidget {
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  String _inputText = "";
  bool _hasDeleteIcon = false;

  String _hintText = '请输入文章标题片段';
  StreamSubscription<SearchChangeEvent> subscription;

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController.fromValue(
        TextEditingValue(
            text: _inputText,
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: _inputText.length))));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: _buildTextField(_controller),
        ),
      ),
      body: SearchResultWidget(_inputText),
    );
  }

  Widget _buildTextField(TextEditingController _controller) {
    return Container(
        child: TextField(
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration(
              hintText: _hintText,
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                //添加边框
                gapPadding: 10.0,
                borderRadius: BorderRadius.circular(30.0),
              ),
              prefixIcon:
                  IconButton(icon: Icon(Icons.arrow_back), onPressed: _goBack),
              suffixIcon: _hasDeleteIcon
                  ? IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.grey,
                      ),
                      padding: EdgeInsets.all(5),
                      onPressed: _clearContent)
                  : null,
              contentPadding: const EdgeInsets.only(right: 0)),
          keyboardType: TextInputType.text,
          onChanged: _onInputChanged,
          onSubmitted: _doSearch,
        ),
        margin: const EdgeInsets.only(right: 0));
  }

  void _clearContent() {
    setState(() {
      _inputText = "";
      _hasDeleteIcon = (_inputText.isNotEmpty);
    });
  }

  void _onInputChanged(String value) {
    setState(() {
      _inputText = value;
      _hasDeleteIcon = (_inputText.isNotEmpty);
    });
  }

  void _doSearch(String value) {
    setState(() {
      _inputText = value;
      eventBus.fire(SearchEvent(value));
    });
  }

  void _goBack() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    subscription = eventBus.on<SearchChangeEvent>().listen((event) {
      String tabText = event.tabText ?? '文章';
      setState(() {
        _hintText = '请输入$tabText标题片段';
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}
