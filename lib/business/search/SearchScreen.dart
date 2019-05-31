import 'package:flutter/material.dart';
import 'SearchResultWidget.dart';

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
        titleSpacing: 0,
        elevation: 0,
        centerTitle: true,
        title: new Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: _buildTextField(_controller),
        ),
      ),
      body: new SearchResultWidget(),
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
        ),
        margin: const EdgeInsets.only(right: 40));
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
