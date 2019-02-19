import 'package:flutter/material.dart';
import 'SearchResult.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPage> {
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
        title: new Container(
          margin: EdgeInsets.all(5),
          child: _buildTextField(_controller),
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.blueAccent,
              ),
              onPressed: null)
        ],
      ),
      body: new SearchResult(),
    );
  }

  TextField _buildTextField(TextEditingController _controller) {
    return new TextField(
      controller: _controller,
      autofocus: true,
      decoration: new InputDecoration(
          hintText: '请输入文章标题片段',
          fillColor: Colors.white,
          filled: true,
          border: new OutlineInputBorder(
            //添加边框
            gapPadding: 10.0,
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: new Icon(Icons.search),
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
    );
  }

  void _clearContent() {
    print('清空输入框');
    setState(() {
      _inputText = "";
      _hasDeleteIcon = (_inputText.isNotEmpty);
    });
  }

  void _onInputChanged(String value) {
    print("输入内容: $value");
    setState(() {
      _inputText = value;
      _hasDeleteIcon = (_inputText.isNotEmpty);
    });
  }
}
