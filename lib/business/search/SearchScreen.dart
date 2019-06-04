import 'package:flutter/material.dart';
import 'SearchResultWidget.dart';
import 'package:myapp/event/EventBus.dart';
import 'package:myapp/event/SearchEvent.dart';

class SearchScreen extends StatefulWidget {
  @override
  SearchScreenState createState() => new SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  String _inputText = "";
  bool _hasDeleteIcon = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController.fromValue(
        TextEditingValue(
            text: _inputText,
            selection: new TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: _inputText.length))));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: new Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: _buildTextField(_controller),
        ),
      ),
      body: new SearchResultWidget(_inputText),
    );
  }

  Widget _buildTextField(TextEditingController _controller) {
    return Container(
        child: new TextField(
          controller: _controller,
          autofocus: true,
          decoration: new InputDecoration(
              hintText: '请输入文章标题片段',
              fillColor: Colors.white,
              filled: true,
              border: new OutlineInputBorder(
                //添加边框
                gapPadding: 10.0,
                borderRadius: BorderRadius.circular(30.0),
              ),
              prefixIcon:
                  IconButton(icon: Icon(Icons.arrow_back), onPressed: _goBack),
              suffixIcon: _hasDeleteIcon
                  ? new IconButton(
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
      eventBus.fire(new SearchEvent(value));
    });
  }

  void _goBack() {
    Navigator.pop(context);
  }
}
